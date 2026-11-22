import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/get_size.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/screens/additional/search_component_v2.dart';
import 'package:tktts_schedule/screens/additional/wheel_picker_v2.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class ScheduleScreen extends StatefulWidget{
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with WidgetsBindingObserver {
  final GlobalKey<SearchComponentV2State> searchKey = GlobalKey<SearchComponentV2State>();
  final GlobalKey<WheelPickerV2State<DateTime>> wheelPickerV2StateKey = GlobalKey<WheelPickerV2State<DateTime>>();
  late Future _data;
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    SessionInfo.instance.scheduleService.onChangeModel = changeModel;
    _data = SessionInfo.instance.scheduleService.uploadScheduleSearch(
      (object) async {
        setState(() {
          SessionInfo.instance.scheduleService.selectedObject = object;
          isLoadingNotifier.value = true;
        });
        
        try {
          await SessionInfo.instance.scheduleService.uploadSchedule();
        
          if (mounted) {
            setState(() {
              isLoadingNotifier.value = false;
            });
          }
        } catch (e) {
          if (mounted) { 
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
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
          children: [
            Positioned.fill(
              child: 
                ListenableBuilder(
                  listenable: Listenable.merge([
                    SessionInfo.instance.scheduleService.currentModelNotifier,
                    SessionInfo.instance.scheduleService.showTypeNotifier,
                    isLoadingNotifier,
                  ]),
                  builder:(context, child) {
                    final value = SessionInfo.instance.scheduleService.currentModelNotifier.value;
                    final showType = SessionInfo.instance.scheduleService.showTypeNotifier.value;
                    final isLoading = isLoadingNotifier.value;

                    return Align(
                      alignment: AlignmentGeometry.topCenter,
                      child: (value == null || isLoading) ? getWidget()
                        : ListenableBuilder(
                        listenable: value.object,
                        builder: (context, child) {
                          if(value.object.groupedLessons.isEmpty){
                            switch(value.receiptType){
                              case(ReceiptType.api):
                                return Center(
                                  child: Text(
                                    'Пар нет😭',
                                    style: TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center,
                                  )
                                );
                              case(ReceiptType.db):
                                return Center(
                                  child: Text(
                                    'Локально пар нет.\nПопробуйте подключится к интернету',
                                    style: TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center,
                                  )
                                );
                              case(ReceiptType.mock):
                                return Center(
                                  child: Text(
                                    'Пары не найдены.',
                                    style: TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center,
                                  )
                                );
                            }
                          }
                          final dates = value.object.groupedLessons.keys.toList();
                          final lessons = value.object.groupedLessons.values.toList();
                          double currentSize;
                          return SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(0, (90 + (value.receiptType == ReceiptType.db ? 50 : 0) + (showType == ShowType.singleDay ? 60 : 0)), 0, 94),
                            child: Wrap(
                              spacing: 24.0,
                              runSpacing: 16.0,
                              alignment: WrapAlignment.center,
                              children: List.generate(dates.length, (index) {
                                final currentDate = dates[index];
                                final currentLessons = lessons[index];
                                currentSize = getSize(cardWidth * 2 + 10, constraints.maxWidth, space: 24.0);
                                String rawDay = DateFormat('EEEE, dd.MM.yyyy').format(currentDate);
                                return SizedBox(
                                  width: currentSize,
                                  child: Card(
                                    color: const Color(0xFFE5F1FD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    margin: EdgeInsets.zero,
                                    elevation: 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.fromLTRB(10, 6, 0, 0),
                                          child: Text(
                                            '${rawDay[0].toUpperCase()}${rawDay.substring(1)}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Wrap(
                                          spacing: 15.0,
                                          runSpacing: 10.0,
                                          children: currentLessons.mapIndexed((index, lesson) {
                                            return SizedBox(
                                              width: getSize(cardWidth, currentSize, screenSpace: 8.0, space: 15.0),
                                              child: Card(
                                                elevation: 0,
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                                ),
                                                clipBehavior: Clip.antiAlias, 
                                                color: lesson.isCurrent() ? Color.fromARGB(255, 173, 215, 255) : Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {

                                                  },
                                                  splashColor: Color.fromARGB(123, 235, 245, 255),
                                                  highlightColor: Color.fromARGB(100, 235, 245, 255),  
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Column(
                                                      spacing: 10,
                                                      children: [
                                                        Row(
                                                          spacing: 30,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center, 
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                spacing: 5,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children:[
                                                                      Text(
                                                                        "${lesson.call.time} пара",
                                                                        textScaler: scaler,
                                                                        textAlign: TextAlign.center,
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w900
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${lesson.call.timeStart} - ${lesson.call.timeEnd}",
                                                                        textScaler: scaler,
                                                                        style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ]
                                                                  ),
                                                                  Text(
                                                                    lesson.couple.subject,
                                                                    textScaler: scaler,
                                                                    style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: value.object.getFooter(lesson),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  )
                                                ),
                                              )
                                            );
                                          }).toList()
                                        ),
                                      ]
                                    ),
                                  ),
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
                    return GlassContainer(
                      child: Column(
                        children: [
                          SearchComponentV2(
                            key: searchKey,
                            objects: SessionInfo.instance.scheduleService.objects,
                            onScheduleObjectSelected: (object) async {
                              await SessionInfo.instance.scheduleService.uploadSchedule(object: object);
                            },
                          ),
                          ListenableBuilder(
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
                              wheelPickerV2StateKey.currentState?.selectedValue = date ?? DateTime.now();
                              return Column(
                                children: [
                                  if(showType == ShowType.singleDay) ...[
                                    Divider(
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsGeometry.only(bottom: 10),
                                      child: WheelPickerV2<DateTime>(
                                        key: wheelPickerV2StateKey,
                                        initialValue: date ?? DateTime.now(),
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
                        ],
                      )
                    );
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
  Widget getWidget(){
    if (isLoadingNotifier.value) {
      return const Center(child: CircularProgressIndicator());
    }
    return const Center(child: Text('Выберите объект'));
  }

  Future changeModel(ScheduleObject? object, Future<void> Function()? action) async {
    final isNotNull = SessionInfo.instance.userInfo.roadMap != null;
    setState(() {
      SessionInfo.instance.scheduleService.selectedObject = object;
      searchKey.currentState?.changeSelection(object);
      if(isNotNull){
        isLoadingNotifier.value = true;
      }
    });
    
    try {
      if(action != null){
        await action();
      }
    
      if (mounted && isNotNull) {
        searchKey.currentState?.changeSelection(object);
        isLoadingNotifier.value = false;
      }
    } catch (e) {
      if (mounted) { 
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