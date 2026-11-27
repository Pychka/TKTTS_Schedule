import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';

abstract class ScheduleObjectService<T extends ScheduleObject, TModel extends BaseModel<T>> {
  String get baseUrl;
  String get entityName;
  TModel modelFromJson(Map<String, dynamic> json);
  T fromJson(Map<String, dynamic> json);
  TModel createEmpty(int id);
  TModel create(T object, List<LessonsModel> lessons);
  Future<TModel> getFromDb(int id);
  Future<List<T>> getListFromDb();
  int collision(LessonsModel oldLesson, List<LessonsModel> newLessons, T object);

  Future<ScheduleObjectMetadata<List<T>>> getMany() async {
    ScheduleObjectMetadata<List<T>> result;
    try{
      final response = await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 10));
      if(response.statusCode == 200){
        final List<dynamic> jsonList = jsonDecode(response.body);
        final objects = jsonList.map((rawJson) {
          final json = Map<String, dynamic>.from(rawJson as Map);
          if (json['updatedAt'] == null) {
            json['updatedAt'] = DateTime.now().toIso8601String();
          }
          return fromJson(json);
        }).toList();

        result = ScheduleObjectMetadata(objects, ReceiptType.api);
      }
      else{
        throw Exception('Не удалось загрузить список ($entityName): код ${response.statusCode}');
      }
    }
    on TimeoutException catch (_) {
      result = ScheduleObjectMetadata(await getListFromDb(), ReceiptType.db);
    }
    on SocketException{
      result = ScheduleObjectMetadata(await getListFromDb(), ReceiptType.db);
    }
    on HandshakeException {
      result = ScheduleObjectMetadata(await getListFromDb(), ReceiptType.db);
    }
    return result;
  }

  Future<ScheduleObjectMetadata<TModel>> get({required int id, DateTime? from}) async {
    try {
      final url = '$baseUrl/$id?timetable=true${from == null ? "" : "&fromDate=$from"}';
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final TModel newModel = modelFromJson(data);
        final changes = await update(newModel);
        return ScheduleObjectMetadata(
          newModel,
          ReceiptType.api,
          changes: (changes.$1, changes.$2),
        );
      }

      if (response.statusCode == 204) {
        return ScheduleObjectMetadata(createEmpty(id), ReceiptType.mock);
      }

      throw Exception('Не удалось загрузить $entityName (код: ${response.statusCode})');
    } on TimeoutException catch(_) {
      return ScheduleObjectMetadata(await getFromDb(id), ReceiptType.db);
    } on SocketException {
      return ScheduleObjectMetadata(await getFromDb(id), ReceiptType.db);
    } on HandshakeException {
      return ScheduleObjectMetadata(await getFromDb(id), ReceiptType.db);
    }
  }

  Future<(List<LessonsModel> removed, List<LessonsModel> added, String name)> update(TModel newModel) async {
    TModel oldModel = await getFromDb(newModel.scheduleObject.id);
    List<LessonsModel> oldLessons = List.from(oldModel.lessons);
    List<LessonsModel> newLessons = List.from(newModel.lessons);
    LessonsModel oldLesson;
    for(int i = 0; i < oldLessons.length; i++){
      oldLesson = oldLessons[i];
      final collision = this.collision(oldLesson, newLessons, newModel.scheduleObject);
      if(collision != -1){
        oldLessons.removeAt(i--);
        newLessons.removeAt(collision);
      }
    }
    if (oldLessons.isNotEmpty) {
      final idsToDelete = oldLessons.map((l) => l.couple.id).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteCouplesByIds(idsToDelete); 
    }

    if (newLessons.isNotEmpty) {
      final modelToSave = create(newModel.scheduleObject, newLessons);
      await modelToSave.save();
    }
    return (oldLessons.toList(), newLessons.toList(), newModel.scheduleObject.name);
  }
}