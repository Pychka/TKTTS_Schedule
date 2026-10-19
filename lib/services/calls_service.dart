import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/session_info.dart';

class CallService {
  final baseUrl = "https://rasp.tktts.ru/api";

  Future<List<Call>> getMany(bool isInit) async {
    List<Call> result = [];
    try{
      final response = await http.get(Uri.parse('$baseUrl/call'));
      if(response.statusCode == 200){
        final List<dynamic> jsonList = jsonDecode(response.body);
        result = jsonList.map((json) => Call.fromJson(json)).toList();
        await updateMany(result);
      }
      else{
        throw Exception('Не удалось загрузить группы');
      }
    }
    on SocketException{
      if(!isInit){
        result = await SessionInfo.instance.scheduleService.dataBase.calls.all().get();
      }
    }
    on HandshakeException {
      if(!isInit){
        result = await SessionInfo.instance.scheduleService.dataBase.calls.all().get();
      }
    }
    return result;
  }

  Future<Call?> get(int weekday, int time) async {
    return await (SessionInfo.instance.scheduleService.dataBase.select(SessionInfo.instance.scheduleService.dataBase.calls)..where((call) => call.time.equals(time) & call.weekday.equals(weekday))..limit(1)).getSingleOrNull();
  }

  Future updateMany(List<Call> auditories) async{
    final old = await SessionInfo.instance.scheduleService.dataBase.calls.all().get();
    List<Call> oldCalls = List.from(old);
    List<Call> newCalls = List.from(auditories);
    Call newCall;
    for(int i = 0; i < newCalls.length; i++){
      newCall = newCalls[i];
      final index = oldCalls.indexWhere((old) => old.time == newCall.time && old.weekday == newCall.weekday);
      if(index != -1){
        oldCalls.removeAt(index);
        newCalls.removeAt(i--);
      }
    }
    if (oldCalls.isNotEmpty) {
      final timesToDelete = oldCalls.map((l) => l.time).toList();
      final weekdaysToDelete = oldCalls.map((l) => l.weekday).toList();
      await SessionInfo.instance.scheduleService.dataBase.deleteCallsByIds(timesToDelete, weekdaysToDelete); 
    }

    if (newCalls.isNotEmpty) {
      await SessionInfo.instance.scheduleService.dataBase.updateCalls(newCalls);
    }
  }
}