import 'package:tktts_schedule/ui_models/lessons_model.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';

class ScheduleObjectMetadata<T> {
  T object;
  ReceiptType receiptType;
  (List<LessonsModel> removed, List<LessonsModel> added) changes;

  ScheduleObjectMetadata(
    this.object,
    this.receiptType,
    { (List<LessonsModel> removed, List<LessonsModel> added)? changes }
  ) : changes = changes ?? ([], []);
}