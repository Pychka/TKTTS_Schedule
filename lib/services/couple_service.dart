import 'package:drift/drift.dart';
import 'package:tktts_schedule/models/data_base.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class CoupleService {
  Future updateMany(List<Couple> auditories, DataBase dataBase) async{
    final old = await dataBase.couples.all().get();
    List<Couple> oldCouples = List.from(old);
    List<Couple> newCouples = List.from(auditories);
    Couple newCouple;
    for(int i = 0; i < newCouples.length; i++){
      newCouple = newCouples[i];
      final index = oldCouples.indexWhere((old) => LessonsModel.coupleIsEquals(old, newCouple));
      if(index != -1){
        oldCouples.removeAt(index);
        newCouples.removeAt(i--);
      }
    }
    if (oldCouples.isNotEmpty) {
      final idsToDelete = oldCouples.map((l) => l.id).toList();
      await dataBase.deleteCouplesByIds(idsToDelete); 
    }

    if (newCouples.isNotEmpty) {
      await dataBase.updateCouples(newCouples);
    }
  }
}