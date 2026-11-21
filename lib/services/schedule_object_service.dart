import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/ui_models/base_model.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/schedule_object_metadata.dart';

abstract class ScheduleObjectService<T extends ScheduleObject, TModel extends BaseModel<T>> {
  Future<ScheduleObjectMetadata<List<T>>> getMany();

  Future<ScheduleObjectMetadata<TModel>> get({required int id, DateTime? from});

  Future<(List<LessonsModel> removed, List<LessonsModel> added, String name)> update(TModel newModel);

  Future updateMany(List<T> auditories);
}