import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:native_workmanager/native_workmanager.dart';

class AndroidBackgroundSyncHelper {
  static const String _taskId = 'periodic-schedule-sync';

  static Future<void> schedulePeriodicSync(int minutes) async {
    if (kIsWeb || !Platform.isAndroid) return;

    final validMinutes = minutes.clamp(15, 120);

    await NativeWorkManager.cancel(taskId: _taskId);

    await NativeWorkManager.enqueue(
      taskId: _taskId,
      trigger: TaskTrigger.periodic(Duration(minutes: validMinutes)),
      worker: DartWorker(callbackId: 'sync-schedule'),
      constraints: Constraints.networkRequired,
    );
  }
}
