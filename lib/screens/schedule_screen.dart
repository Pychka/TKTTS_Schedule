import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/receipt_type.dart';
import 'package:tktts_schedule/screens/additional/search_component.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ScheduleScreen extends StatefulWidget{
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with WidgetsBindingObserver {
  late Future _data;
  bool isLoadingSchedule = false;
  @override
  void initState() {
    super.initState();
    _data = SessionInfo.instance.scheduleService.uploadScheduleSearch(
      (object) async {
        setState(() {
          SessionInfo.instance.scheduleService.selectedObject = object;
          isLoadingSchedule = true;
        });
        
        try {
          await SessionInfo.instance.scheduleService.uploadSchedule();
        
          if (mounted) {
            setState(() {
              isLoadingSchedule = false;
            });
          }
        } catch (e) {
          if (context.mounted) { 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Не удалось загрузить расписание. Проверьте интернет.'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          print('Ошибка загрузки: $e');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaler = TextScaler.linear(1);
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Stack(
        children: [
          Positioned.fill(
            child: 
              ValueListenableBuilder(
                valueListenable: SessionInfo.instance.scheduleService.currentModelNotifier,
                builder:(context, value, child) =>
                  Center(
                    child: (value == null || isLoadingSchedule) ? getWidget()
                     : ListenableBuilder(
                    listenable: SessionInfo.instance.scheduleService.currentModelNotifier,
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
                                'Локально пар нет.\nПопробуйте подключится к интернету',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              )
                            );
                        }
                      }
                      final dates = SessionInfo.instance.scheduleService.currentModel?.object.groupedLessons.keys.toList();
                      final lessons = SessionInfo.instance.scheduleService.currentModel?.object.groupedLessons.values.toList();
                      if(lessons == null || dates == null){
                        return Text("Null!");
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 80, 0, 84), 
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          final currentDate = dates[index];
                          final currentLessons = lessons[index];
                          
                          String rawDay = DateFormat('EEEE, dd.MM.yyyy').format(currentDate);
                          
                          return SizedBox(
                            width: min(screenWidth, min((8 + 408 * lessons.length).toDouble(), 824)),
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
                                                        Divider(
                                                          
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
                                                          child: SessionInfo.instance.scheduleService.currentModel!.object.getFooter(lesson),
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
                        }
                      );
                    },
                  ),
                ),
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
                  return SearchComponent(
                    key: const ValueKey('main_search'),
                    objects: SessionInfo.instance.scheduleService.objects,
                    onScheduleObjectSelected: (object) async {
                      setState(() {
                        SessionInfo.instance.scheduleService.selectedObject = object;
                        isLoadingSchedule = true;
                      });
                      
                      try {
                        await SessionInfo.instance.scheduleService.uploadSchedule();
                      
                        if (mounted) {
                          setState(() {
                            isLoadingSchedule = false;
                          });
                        }
                      } catch (e) {
                        if (context.mounted) { 
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Не удалось загрузить расписание. Проверьте интернет.'),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                        print('Ошибка загрузки: $e');
                      }
                    },
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
    );

    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => const MainScreen()),
    // );
  }
  Widget getWidget(){
    if (isLoadingSchedule) {
      return const Center(child: CircularProgressIndicator());
    }
    return const Center(child: Text('Выберите объект'));
  }
}