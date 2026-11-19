import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class SearchComponentV2 extends StatefulWidget {
  final List<ScheduleObject> objects;
  final ValueChanged<ScheduleObject?> onScheduleObjectSelected; 

  const SearchComponentV2({
    super.key, 
    required this.objects,
    required this.onScheduleObjectSelected
  });

  @override
  State<SearchComponentV2> createState() => SearchComponentV2State();
}

class SearchComponentV2State extends State<SearchComponentV2> {
  final FocusNode _focusNode = FocusNode();
  final SearchController _searchController = SearchController();
  ScheduleObject? selectedObject;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final iconButtonStyle = IconButton.styleFrom(
      backgroundColor: Color(0xFF3FA2FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      padding: const EdgeInsets.all(6),
    );

    final query = _searchController.text.toLowerCase();
    final groupedData = widget.objects
        .where((group) => group.name.toLowerCase().contains(query))
        .toList()
      ..sort(SessionInfo.instance.scheduleService.compareObjects);

    return GlassContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      style: textStyle,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: 'Выберите из списка...',
                        hintStyle: textStyle,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onTap: () {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                      onChanged: (_) {
                        setState(() {
                          _isExpanded = true;
                        });
                      },
                    ),
                  ),
                  if (_isExpanded)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          if (_searchController.text.isNotEmpty) {
                            _searchController.clear();
                          } else {
                            _isExpanded = false;
                            _focusNode.unfocus();
                          }
                        });
                      },
                    ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: const Color.fromARGB(183, 0, 0, 0),
                      highlightColor: const Color(0xB73FA2FF),
                    ),
                    child: PopupMenuButton<ShowType>(
                      icon: const Icon(Icons.filter_list, color: Colors.white, size: 32),
                      tooltip: 'Тип отображения',
                      style: iconButtonStyle,
                      menuPadding: EdgeInsets.zero,
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      elevation: 0, 
                      initialValue: SessionInfo.instance.userInfo.showType,
                      onSelected: (ShowType type) {
                        setState(() {
                          SessionInfo.instance.scheduleService.showType = type;
                        });
                      },
                      itemBuilder: (BuildContext popupContext) => [
                        PopupMenuItem<ShowType>(
                          enabled: false,
                          padding: EdgeInsets.zero,
                          child: GlassContainer(
                            blurSigma: 4.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  child: Text(
                                    'Тип отображения',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Divider(height: 1, color: Colors.white),
                                _buildGlassMenuItem(popupContext, ShowType.all, "Полностью"),
                                _buildGlassMenuItem(popupContext, ShowType.fromToday, "С текущего дня"),
                                _buildGlassMenuItem(popupContext, ShowType.today, "Текущий день"),
                                _buildGlassMenuItem(popupContext, ShowType.singleDay, "Отдельные дни", isLast: true),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            )
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(height: 1, color: Colors.white54),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 260),
                        child: groupedData.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Ничего не найдено',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                itemCount: groupedData.length,
                                itemBuilder: (context, index) {
                                  final group = groupedData[index];
                                  return StatefulBuilder(
                                    builder: (context, setStateLocal) {
                                      return ListTile(
                                        dense: true,
                                        splashColor: const Color(0x663FA2FF),
                                        title: Text(
                                          group.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            setStateLocal(() {
                                              SessionInfo.instance.userInfo.addFavorite(group);
                                            });
                                          },
                                          icon: SessionInfo.instance.userInfo.getFavoriteIcon(group),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedObject = group;
                                            _searchController.text = group.name;
                                            _isExpanded = false;
                                          });
                                          _focusNode.unfocus();
                                          widget.onScheduleObjectSelected(group);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      )
    );
  }

  Widget  _buildGlassMenuItem(BuildContext popupContext, ShowType value, String title, { bool isLast = false, }) {
    final isSelected = SessionInfo.instance.userInfo.showType == value;
    final radius = isLast
      ? const BorderRadius.vertical(bottom: Radius.circular(20))
      : BorderRadius.zero;

    return InkWell(
      onTap: () => Navigator.pop(popupContext, value),
      borderRadius: radius,
      child: Container(
        width: double.infinity,
        color:  isSelected ? Color(0xB73FA2FF) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void changeSelection(ScheduleObject? obj){
    setState(() {
      selectedObject = obj; 
      _searchController.text = obj?.name ?? "";
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}