import 'package:flutter/material.dart';
import 'package:tktts_schedule/logic/search/is_equals_strings.dart';
import 'package:tktts_schedule/logic/search/split_and_clean.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class SearchComponentV2 extends StatefulWidget {
  final List<ScheduleObject> objects;
  final bool isExpanded;
  final ValueChanged<bool> onExpandedChanged;

  const SearchComponentV2({
    super.key, 
    required this.objects,
    required this.isExpanded,
    required this.onExpandedChanged,
  });

  @override
  State<SearchComponentV2> createState() => SearchComponentV2State();
}

class SearchComponentV2State extends State<SearchComponentV2> {
  List<ScheduleObject> objectsToShow = [];
  final Map<ScheduleObject, List<String>> _tokensCache = {};
  final FocusNode _focusNode = FocusNode();
  String query = "";
  final SearchController _searchController = SearchController();

  List<String> _getCachedTokens(ScheduleObject obj) {
    return _tokensCache.putIfAbsent(obj, () => getClean(obj.name));
  }

  @override void initState() {
    super.initState();
    objectsToShow = widget.objects;
    query = SessionInfo.instance.scheduleService.selectedObjectNotifier.value?.name ?? "";
    _searchController.text = query;
    SessionInfo.instance.scheduleService.selectedObjectNotifier.addListener(_onExternalSelection);
  }

  void _onExternalSelection() {
    final selected = SessionInfo.instance.scheduleService.selectedObjectNotifier.value;
     if (selected != null && _searchController.text != selected.name) {
      setState(() {
        _searchController.text = selected.name;
        query = selected.name;
      });
      search();
    } else if (selected == null && _searchController.text.isNotEmpty) {
      setState(() {
        _searchController.clear();
        query = "";
      });
      search();
    }
  }


 @override
  void didUpdateWidget(covariant SearchComponentV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
     if (oldWidget.objects != widget.objects) {
      _tokensCache.clear();
      if (query.isEmpty) {
        setState(() => objectsToShow = widget.objects);
      } else {
        search();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 20,
    );
    final iconButtonStyle = IconButton.styleFrom(
      backgroundColor: Color(0xFF3FA2FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      padding: const EdgeInsets.all(6),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Row(
            spacing: 0,
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
                    widget.onExpandedChanged(true);
                  },
                  onChanged: (value) {
                    query = value;
                    widget.onExpandedChanged(true);
                    search();
                  },
                ),
              ),
              if (widget.isExpanded)
                ...[
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          setState(() {
                            _searchController.clear();
                            query = _searchController.text;
                          });
                        } else {
                          widget.onExpandedChanged(false);
                          setState(() {
                            _focusNode.unfocus();
                          });
                        }
                      search();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        widget.onExpandedChanged(false);
                        _focusNode.unfocus();
                      });
                    },
                  ),
                ],
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: const Color.fromARGB(183, 133, 167, 199),
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
                  initialValue:  SessionInfo.instance.scheduleService.showType,
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
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          child: widget.isExpanded
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(height: 1, color: Colors.white54),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 260),
                    child: objectsToShow.isEmpty
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
                            itemCount: objectsToShow.length,
                            itemBuilder: (context, index) {
                              final group = objectsToShow[index];
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
                                    setState(() {
                                      SessionInfo.instance.userInfo.addFavorite(group);
                                    });
                                  },
                                  icon: _getFavoriteIcon(group),
                                ),
                                onTap: () async {
                                  setState(() {
                                    _searchController.text = group.name;
                                    widget.onExpandedChanged(false);
                                  });
                                  await SessionInfo.instance.scheduleService.uploadSchedule(object: group);
                                  _focusNode.unfocus();
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
    );
  }

  Icon _getFavoriteIcon(ScheduleObject obj){
    final any = SessionInfo.instance.userInfo.isFavorite(obj);
    return Icon(
      any ? Icons.favorite_sharp
          : Icons.favorite_outline,
      color:
        any ? Color(0xEFff0284)
        : Colors.grey
      );
  }

  Widget  _buildGlassMenuItem(BuildContext popupContext, ShowType value, String title, { bool isLast = false, }) {
    final isSelected = SessionInfo.instance.scheduleService.showType == value;
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

  void search(){
    final List<({ScheduleObject obj, double score})> scoredData = [];

    if (query.isEmpty) {
      setState(() => objectsToShow = widget.objects);
      return;
    } else {
      final queryTokens = getClean(query);
      for (final so in widget.objects) {
        final score = isEqualsString(
          so.name,
          query,
          first: _getCachedTokens(so),
          second: queryTokens,
        );
        if (score >= 0.7) {
          scoredData.add((obj: so, score: score));
        }
      }
    }

    scoredData.sort((a, b) {
      final scoreDiff = b.score.compareTo(a.score);
      if (scoreDiff != 0) return scoreDiff;
      
      return SessionInfo.instance.scheduleService.compareObjects(a.obj, b.obj);
    });

    setState(() => objectsToShow = scoredData.map((e) => e.obj).toList());
  }

  @override
  void dispose() {
    SessionInfo.instance.scheduleService.selectedObjectNotifier.removeListener(_onExternalSelection);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}