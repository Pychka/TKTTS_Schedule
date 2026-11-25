import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/screens/additional/search_component_v2.dart';
import 'package:tktts_schedule/screens/additional/wheel_picker_v2.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class ScheduleMenuHeader extends StatefulWidget{
  const ScheduleMenuHeader({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _ScheduleMenuHeaderState();
}

class _ScheduleMenuHeaderState extends State<ScheduleMenuHeader> with WidgetsBindingObserver {
  bool _isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        children: [
          SearchComponentV2(
            isExpanded: _isSearchExpanded,
            onExpandedChanged: (expanded) {
              setState(() {
                _isSearchExpanded = expanded;
              });
            },
            objects: SessionInfo.instance.scheduleService.objects,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _isSearchExpanded ? SizedBox.shrink() : ListenableBuilder(
              listenable: Listenable.merge([
                SessionInfo.instance.scheduleService.currentModelNotifier,
                SessionInfo.instance.scheduleService.showTypeNotifier,
                SessionInfo.instance.scheduleService.selectedDateNotifier,
              ]),
              builder: (context, child) {
                final model = SessionInfo.instance.scheduleService.currentModelNotifier.value;
                final showType = SessionInfo.instance.scheduleService.showTypeNotifier.value;
                final date = SessionInfo.instance.scheduleService.selectedDateNotifier.value;
                if(model == null) {
                  return const SizedBox.shrink();
                }
                final dates = model.object.groupedRawLessons.keys.toList();
                return Column(
                  children: [
                    if(showType == ShowType.singleDay && dates.isNotEmpty) ...[
                      Divider(
                        color: Color(0xFFFFFFFF),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 10),
                        child: WheelPickerV2<DateTime>(
                          initialValue: date ?? model.object.groupedRawLessons.keys.first,
                          values: model.object.groupedRawLessons.keys.toList(),
                          fontSize: 20,
                          baseTextColor: Colors.white,
                          onChanged: (value) {
                            SessionInfo.instance.scheduleService.selectedDate = value;
                          },
                          labelBuilder: (value) => DateFormat('dd E').format(value)
                        ),
                      ),
                    ],
                    if(model.receiptType == ReceiptType.db) ...[
                      Divider(
                        color: Color(0xFFFFFFFF),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 10),
                        child: Text(
                          'Расписание актуально с ${DateFormat('dd.MM.yyyy HH:mm').format(model.object.scheduleObject.updatedAt)}',
                          style: TextStyle(
                            fontSize: 17.6,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFFFFFF)
                          ),
                        ),
                      )
                    ]
                  ],
                );
              }
            ),
          ),
        ],
      )
    );
  }
}