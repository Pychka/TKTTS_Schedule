import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/get_size.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/day_card.dart';
import 'package:tktts_schedule/screens/additional/schedule_menu_header.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class ScheduleScreen extends StatefulWidget{
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with WidgetsBindingObserver {
  late Future _data;
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    SessionInfo.instance.scheduleService.onChangeModel = _changeModel;
    _data = SessionInfo.instance.scheduleService.uploadScheduleSearch(
      (object) async {
        SessionInfo.instance.scheduleService.selectedObject = object;
        isLoadingNotifier.value = true;
        
        try {
          await SessionInfo.instance.scheduleService.uploadSchedule();
        
          if (mounted) {
            SessionInfo.instance.scheduleService.selectedObjectNotifier.value = object;
            isLoadingNotifier.value = false;
          }
        } catch (e) {
          if (mounted) { 
            isLoadingNotifier.value = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Не удалось загрузить расписание. Проверьте интернет.'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = 300.0;
    final scaler = TextScaler.linear(1);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
          children: [
            Positioned.fill(
              child: 
                ListenableBuilder(
                  listenable: Listenable.merge([
                    SessionInfo.instance.scheduleService.currentModelNotifier,
                    SessionInfo.instance.scheduleService.selectedDateNotifier,
                    SessionInfo.instance.scheduleService.showTypeNotifier,
                    isLoadingNotifier,
                  ]),
                  builder:(context, child) {
                    final value = SessionInfo.instance.scheduleService.currentModelNotifier.value;
                    final showType = SessionInfo.instance.scheduleService.showTypeNotifier.value;
                    final isLoading = isLoadingNotifier.value;

                    return Align(
                      alignment: AlignmentGeometry.topCenter,
                      child: (value == null || isLoading) ? _getWidget()
                        : ListenableBuilder(
                        listenable: value.object,
                        builder: (context, child) {
                          if(value.object.groupedLessons.isEmpty){
                            return _buildEmptyState(value.receiptType);
                          }
                          final dates = value.object.groupedLessons.keys.toList();
                          final lessons = value.object.groupedLessons.values.toList();
                          final topPadding = 90.0 + (value.receiptType == ReceiptType.db ? 50.0 : 0.0) + (showType == ShowType.singleDay ? 60.0 : 0.0);
                          double currentSize;
                          return SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(0, topPadding, 0, 94),
                            child: Wrap(
                              spacing: 24.0,
                              runSpacing: 24.0,
                              alignment: WrapAlignment.center,
                              children: List.generate(dates.length, (index) {
                                currentSize = showType == ShowType.singleDay || showType == ShowType.today ? constraints.maxWidth : getSize(cardWidth * 2 + 24, max: cardWidth * 3 + 48, constraints.maxWidth, space: 24.0);
                                final lessonWidth = getSize(cardWidth, currentSize, screenSpace: 8.0, space: 15.0);
                                
                                return DayCard(
                                  date: dates[index],
                                  lessons: lessons[index],
                                  cardWidth: currentSize,
                                  scaler: scaler,
                                  lessonWidth: lessonWidth,
                                  footerBuilder: (lesson, isCurrent) => 
                                    value.object.getFooter(lesson, isCurrent),
                                );
                              }
                            )
                          )
                        );
                      },
                    ),
                  );
                }
              )
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 0,
              right: 0,
              child: FutureBuilder(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  else if (snapshot.hasError) { 
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ошибка загрузки: ${snapshot.error}'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    });
                    
                    return const SizedBox.shrink();
                  }
                  else if (snapshot.hasData && snapshot.data == true) {
                    return ScheduleMenuHeader();
                  }
                  return const Center(
                    child: Text(
                      'Нет данных',
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      })
    );
  }

  Widget _getWidget(){
    if (isLoadingNotifier.value) {
      return const Center(child: CircularProgressIndicator());
    }
    return const Center(child: Text('Выберите объект'));
  }

  Widget _buildEmptyState(ReceiptType type) {
    String text;
    switch (type) {
      case ReceiptType.api: text = 'Пар нет😭'; break;
      case ReceiptType.db: text = 'Локально пар нет.\nПопробуйте подключится к интернету'; break;
      case ReceiptType.mock: text = 'Пары не найдены.'; break;
    }
    return Center(
      child: Text(text, style: const TextStyle(fontSize: 30), textAlign: TextAlign.center),
    );
  }

  Future _changeModel(ScheduleObject? object, Future<void> Function()? action) async {
    final isNotNull = SessionInfo.instance.userInfo.roadMap != null;
    SessionInfo.instance.scheduleService.selectedObject = object;
    SessionInfo.instance.scheduleService.selectedObjectNotifier.value = object;
    if(isNotNull){
      isLoadingNotifier.value = true;
    }
    
    try {
      if(action != null){
        await action();
      }
    
      if (mounted && isNotNull) {
        SessionInfo.instance.scheduleService.selectedObjectNotifier.value = object;
        isLoadingNotifier.value = false;
      }
    } catch (e) {
      if (mounted) { 
        isLoadingNotifier.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Не удалось загрузить расписание. Проверьте интернет.'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
  
  @override
  void dispose() {
    isLoadingNotifier.dispose();
    super.dispose();
  }
}