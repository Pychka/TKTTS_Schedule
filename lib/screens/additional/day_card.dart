import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tktts_schedule/screens/additional/lesson_card.dart';
import 'package:tktts_schedule/ui_models/lessons_model.dart';

class DayCard extends StatelessWidget {
  final DateTime date;
  final List<LessonsModel> lessons;
  final double cardWidth;
  final TextScaler scaler;
  final double lessonWidth;
  final Widget Function(LessonsModel, bool) footerBuilder;

  const DayCard({
    super.key,
    required this.date,
    required this.lessons,
    required this.cardWidth,
    required this.scaler,
    required this.lessonWidth,
    required this.footerBuilder,
  });

  @override
  Widget build(BuildContext context) {
    String rawDay = DateFormat('EEEE, dd.MM.yyyy').format(date);
    
    return SizedBox(
      width: cardWidth,
      child: Card(
        color: const Color(0xFFE5F1FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
              child: Text(
                '${rawDay[0].toUpperCase()}${rawDay.substring(1)}',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(),
            Wrap(
              spacing: 15.0,
              runSpacing: 10.0,
              children: lessons.map((lesson) {
                final isCurrent = lesson.isCurrent();
                return LessonCard(
                  lesson: lesson,
                  isCurrent: isCurrent,
                  width: lessonWidth,
                  scaler: scaler,
                  footer: footerBuilder(lesson, isCurrent),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}