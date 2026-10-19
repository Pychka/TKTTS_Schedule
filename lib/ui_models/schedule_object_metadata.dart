import 'package:tktts_schedule/ui_models/receipt_type.dart';

class ScheduleObjectMetadata<T> {
  T object;
  ReceiptType receiptType;

  ScheduleObjectMetadata(
    this.object,
    this.receiptType
  );
}