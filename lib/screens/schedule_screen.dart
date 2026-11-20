import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/screens/additional/search_component_v2.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';

class ScheduleScreen extends StatefulWidget{
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with WidgetsBindingObserver {
  final GlobalKey<SearchComponentV2State> searchKey = GlobalKey<SearchComponentV2State>();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final scaler = TextScaler.linear(1);
    return PopScope(
      canPop: false, 
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        debugPrint(didPop.toString());
        if (didPop) return;

        if(SessionInfo.instance.userInfo.back()){
          await SessionInfo.instance.scheduleService.changeModel(SessionInfo.instance.userInfo.roadMap);
        }
        else{
          final bool shouldLeave = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Выйти?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Остаться'),
                ),
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (!Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ) ??
          false;

          if (shouldLeave && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Stack(
          children: [
            Positioned.fill(
              child: 
                ListenableBuilder(
                  listenable: Listenable.merge([
                    SessionInfo.instance.scheduleService.currentModelNotifier,
                    isLoadingNotifier,
                  ]),
                  builder:(context, child) {
                    final value = SessionInfo.instance.scheduleService.currentModelNotifier.value;
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
                          double size = screenWidth;
                          double currentSize;
                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(0, value.receiptType == ReceiptType.db ? 130.0 : 80.0, 0, 84),
                              child: Wrap(
                              spacing: 16.0,
                              runSpacing: 24.0,
                              alignment: WrapAlignment.center,
                              children: List.generate(dates.length, (index) {
                                final currentDate = dates[index];
                                final currentLessons = lessons[index];
                                if(size < 442){
                                  size = screenWidth;
                                }
                                currentSize = min(size, min((8 + 408 * 3).toDouble(), 824));
                                size -= (currentSize + 26);
                                String rawDay = DateFormat('EEEE, dd.MM.yyyy').format(currentDate);
                                return SizedBox(
                                  width: currentSize,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      Text(
                                        '${rawDay[0].toUpperCase()}${rawDay.substring(1)}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),                              
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 8.0,
                                        children: currentLessons.map((lesson) {
                                          return SizedBox(
                                            width: min(screenWidth, 400),
                                            child: Card(
                                              color: const Color(0xFFdceeff),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  spacing: 20,
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
                                                              Divider(),
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
                                            )
                                          );
                                        }).toList()
                                      ),
                                    ]
                                  )
                                );
                              })
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
                    bool isSetted = false;
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
                            listenable: SessionInfo.instance.scheduleService.currentModelNotifier,
                            builder: (context, child) {
                              final value = SessionInfo.instance.scheduleService.currentModelNotifier.value;
                              if(value == null) {
                                return const SizedBox.shrink();
                              }
                              switch(value.receiptType){
                                case ReceiptType.db:
                                  String rawDay = DateFormat('dd.MM.yyyy HH:mm').format(value.object.scheduleObject.updatedAt);
                                  if(!isSetted){
                                    isSetted = true;
                                  }
                                  return Column(
                                    children: [
                                      Divider(
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 10),
                                        child: Text(
                                          'Расписание актуально с $rawDay',
                                          style: TextStyle(
                                            fontSize: 17.6,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFFFFFFFF)
                                          ),
                                        ),
                                      )
                                    ],
                                  ); 
                                default: 
                                  if(isSetted){
                                    isSetted = false;
                                  }
                                return const SizedBox.shrink();
                              }
                            }
                          )
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
        ),
      )
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