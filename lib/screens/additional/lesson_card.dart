import 'package:flutter/material.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class LessonCard extends StatelessWidget {
  final LessonsModel lesson;
  final bool isCurrent;
  final double width;
  final TextScaler scaler;
  final Widget footer;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.isCurrent,
    required this.width,
    required this.scaler,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isCurrent ? Colors.white : Colors.black;
    
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        color: isCurrent ? const Color.fromARGB(255, 156, 207, 255) : Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: const Color.fromARGB(122, 162, 209, 255),
          highlightColor: const Color.fromARGB(158, 119, 187, 255),
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
                            children: [
                              Text(
                                "${lesson.call.time} пара",
                                textScaler: scaler,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                "${lesson.call.timeStart} - ${lesson.call.timeEnd}",
                                textScaler: scaler,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            lesson.couple.subject,
                            textScaler: scaler,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          footer,
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}