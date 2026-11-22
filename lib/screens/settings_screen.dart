import 'package:flutter/material.dart';
import 'package:tktts_schedule/get_size.dart';
import 'package:tktts_schedule/ui_models/settings_group.dart';

class SettingsScreen extends StatefulWidget{
  final List<SettingsGroup> groups;
  const SettingsScreen({
    required this.groups,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  final buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 75, 168, 255),
    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    elevation: 3, 
    shadowColor: Colors.black.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ); 
  final textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 84),
          child: Wrap(
            spacing: 10,
            children: 
              List.generate(widget.groups.length, (index) {
                final group = widget.groups[index];
                return SizedBox(
                  width: getSize(400, constraints.maxWidth, space: 10, screenSpace: 10),
                  child: Card(
                    color: const Color(0xFFE5F1FD),
                    child: Padding(
                      padding:  EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsGeometry.fromLTRB(8, 8, 8, 0), 
                                child: Icon(
                                  group.icon,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  group.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if(group.widgets.isNotEmpty)
                            ...group.widgets
                        ],
                      ),
                    )
                  ),
                );
              }
            )
          ),
        ),
      );
    });
  }
}