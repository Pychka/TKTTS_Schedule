import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class SearchComponent extends StatefulWidget {
  final List<ScheduleObject> objects;
  final ValueChanged<ScheduleObject?> onScheduleObjectSelected; 

  const SearchComponent({
    super.key, 
    required this.objects,
    required this.onScheduleObjectSelected
  });

  @override
  State<SearchComponent> createState() => SearchComponentState();
}

class SearchComponentState extends State<SearchComponent> {
  final SearchController _searchController = SearchController();
  ScheduleObject? selectedObject;

  @override
  Widget build(BuildContext context) {
    final iconButtonStyle = IconButton.styleFrom(
      backgroundColor: Color(0xCE8cafff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
    );
    return SearchAnchor(
      isFullScreen: false, 
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      viewBackgroundColor: Color(0xFFdceeff), 
      viewElevation: 0, 
      viewLeading: const SizedBox.shrink(), 
      viewConstraints: const BoxConstraints(
        maxHeight: 300,
      ),
      searchController: _searchController,
      builder: (BuildContext context, SearchController controller) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: SearchBar(
              constraints: const BoxConstraints(maxHeight: 70, minHeight: 70),
              backgroundColor: const WidgetStatePropertyAll(Color(0xC1dceeff)),
              elevation: const WidgetStatePropertyAll(0),
              controller: controller,
              shape: WidgetStateProperty.resolveWith<OutlinedBorder>((states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Color(0x76FFFFFF), width: 1.5)
                );
              }),
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              trailing: [
                Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Color(0xCE8cafff),
                    highlightColor: Color(0xAB8cafff),
                  ),
                  child: PopupMenuButton<ShowType>(
                    icon: const Icon(Icons.filter_list, color: Colors.white, size: 32,),
                    tooltip: 'Тип отображения',

                    style: iconButtonStyle,
                    color: Color(0xFFdceeff),
                    initialValue: SessionInfo.instance.userInfo.showType,
                    onSelected: (ShowType type) {
                      setState(() {
                        SessionInfo.instance.scheduleService.showType = type;
                      });
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem<ShowType>(
                        enabled: false,
                        child: Text(
                          'Тип отображения',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const PopupMenuDivider(height: 1),

                      const PopupMenuItem(
                        value: ShowType.all,
                        child: Text("Полностью"),
                      ),
                      const PopupMenuItem(
                        value: ShowType.fromToday,
                        child: Text("С текущего дня"),
                      ),
                      const PopupMenuItem(
                        value: ShowType.today,
                        child: Text("Текущий день"),
                      ),
                      const PopupMenuItem(
                        value: ShowType.today,
                        child: Text("Отдельные дни"),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 32,),
                  style: iconButtonStyle,
                  onPressed: () async {
                    await SessionInfo.instance.scheduleService.uploadSchedule();
                  },
                )
              ],
              hintText: 'Выберите из списка...',
            )
            )
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          final query = controller.text.toLowerCase();
          final groupedData = widget.objects.where((group) => group.name.toLowerCase().contains(query)).toList();

          if (groupedData.isEmpty) {
            return [
              const ListTile(
                title: Text('Ничего не найдено', style: TextStyle(color: Colors.black)),
              )
            ];
          }
          groupedData.sort(SessionInfo.instance.scheduleService.compareObjects);
          return groupedData.map((group) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateLocal) {
                  return ListTile(
                    enabled: true,
                    dense: true,
                    title: Text(group.name),
                    
                    trailing: IconButton(
                      onPressed: () {
                        setStateLocal(() {
                          SessionInfo.instance.userInfo.addFavorite(group);
                        });
                      },
                      icon: SessionInfo.instance.userInfo.getFavoriteIcon(group),
                    ),
                    
                    onTap: () async {
                      setState(() {
                        selectedObject = group; 
                        _searchController.text = group.name;
                        widget.onScheduleObjectSelected(group);
                      });
                      controller.closeView(group.name); 
                      await SessionInfo.instance.scheduleService.uploadSchedule();
                    },
                  );
                },
              );
            }).toList();
        },
      );
  }

  void changeSelection(ScheduleObject obj){
    setState(() {
      selectedObject = obj; 
      _searchController.text = obj.name;
      widget.onScheduleObjectSelected(obj);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}