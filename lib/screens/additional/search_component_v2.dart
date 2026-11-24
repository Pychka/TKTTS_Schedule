import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/models/schedule_object.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';
import 'package:tktts_schedule/session_info.dart';
import 'package:tktts_schedule/ui_models/show_type.dart';

class SearchComponentV2 extends StatefulWidget {
  final List<ScheduleObject> objects;
  final ValueChanged<ScheduleObject?> onScheduleObjectSelected;
  final bool isExpanded;
  final ValueChanged<bool> onExpandedChanged;

  const SearchComponentV2({
    super.key, 
    required this.objects,
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.onScheduleObjectSelected
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
  ScheduleObject? selectedObject;

  List<String> _getCachedTokens(ScheduleObject obj) {
    return _tokensCache.putIfAbsent(obj, () => _getClean(obj.name));
  }

 @override
  void didUpdateWidget(covariant SearchComponentV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.objects != widget.objects) {
      _tokensCache.clear();
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
                    setState(() {
                      widget.onExpandedChanged(true);
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      query = value;
                      widget.onExpandedChanged(true);
                    });
                    search();
                  },
                ),
              ),
              if (widget.isExpanded)
                ...[
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (_searchController.text.isNotEmpty) {
                          _searchController.clear();
                          query = _searchController.text;
                        } else {
                          widget.onExpandedChanged(false);
                          _focusNode.unfocus();
                        }
                      });
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
                                        widget.onExpandedChanged(false);
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

  void search(){
    final List<({ScheduleObject obj, double score})> scoredData = [];

    if (query.isEmpty) {
      setState(() => objectsToShow = widget.objects);
      return;
    } else {
      final queryTokens = _getClean(query);
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

  void changeSelection(ScheduleObject? obj){
    setState(() {
      selectedObject = obj; 
      _searchController.text = obj?.name ?? "";
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

List<String> splitAndClean(
  String str,
  String toSplit,
  List<String>? toRemove, {
  List<String>? toClean,
  List<String>? toClear,
  int minSize = 3,
}) {
  final List<String> result = [];
  str = str.toLowerCase();
  int start = 0;
  String second;
  String? third;
  String ch;

  for (int i = 0; i < str.length; i++) {
    ch = str[i];
    if (ch == toSplit) {
      if (i + 1 < str.length) {
        second = str[i + 1];
        third = i + 2 < str.length ? str[i + 2] : null;

        if ((second == toSplit || third == toSplit) && minSize > i - start) {
          str = str.replaceRange(i, i + 1, '');
          i--;
          continue;
        }

        if (third != toSplit && toRemove != null && toRemove.contains(second)) {
          str = str.replaceRange(i + 1, i + 2, ' ');
          i--;
          continue;
        }

        if (minSize > i - start) {
          str = str.replaceRange(i, i + 1, '');
          i--;
          continue;
        }
      }

      if (start != i) {
        result.add(str.substring(start, i));
        str = str.replaceRange(i, i + 1, '');
        i--;
      }
      start = i + 1;
    }

    if (start == i && toClean?.contains(ch) == true) {
      start = i + 1;
    }

    if (toRemove?.contains(ch) == true) {
      str = str.replaceRange(i, i + 1, ' ');
      i--;
      continue;
    }
  }

  if (start < str.length) {
    result.add(str.substring(start));
  }

  if (toClear != null) {
    for (final String f in List<String>.from(result)) {
      final String q = f.split('').where((c) => !toClear.contains(c)).join();

      if (f != q && !result.contains(q)) {
        result.add(q);
      }

      if (f != q) {
        final subTokens = splitAndClean(
          f,
          toSplit,
          toClear,
          toClean: toClean,
          toClear: null,
          minSize: minSize,
        );
        for (final sub in subTokens) {
          if (!result.contains(sub)) {
            result.add(sub);
          }
        }
      }
    }
  }

  return result;
}

double isEqualsString(
  String a,
  String b, {
  required List<String> first,
  required List<String> second,
  double coefficient = 0.7,
}) {
  b = b.toLowerCase();
  if (a.startsWith(b)) return 1.1;

  if (second.isEmpty) return 1.1;

  if (first.isEmpty) return 0.0;

  List<double> ks = [];
  final List<bool> used = List<bool>.filled(first.length, false);

  for (final queryWord in second) {
    int bestIdx = -1;
    double bestK = 0.0;

    for (int i = 0; i < first.length; i++) {
      if (used[i]) continue;
      final k = isEquals(first[i], queryWord);
      if (k > bestK) {
        bestK = k;
        bestIdx = i;
      }
    }

    if (bestIdx == -1 || bestK < coefficient) return 0.0;

    used[bestIdx] = true;
    ks.add(bestK);
  }

  return ((ks.sum / second.length) + (pow(ks.fold(1, (acc, item) => acc * item), 1 / second.length))) / coefficient;
}

double isEquals(String target, String query, {double min = 0.7}) {
  if (query.isEmpty || target.isEmpty) return 0.0;
  if (target.startsWith(query)) return 1.1;

  final int window = max(2, (target.length ~/ 2) - 1);
  final double k = (1 / query.length);
  if (query.length > target.length + window) return 0.0;

  double maxPossibleWeight = 0.0;
  double earnedWeight = 0.0;
  final List<bool> used = List<bool>.filled(target.length, false);

  for (int i = 0; i < query.length; i++) {
    final String ch = query[i];
    final double charImportance = (i == 0) ? 1.5 : 1.0;
    maxPossibleWeight += charImportance;

    if (i < target.length && !used[i] && ch == target[i]) {
      earnedWeight += charImportance;
      used[i] = true;
      continue;
    }

    final int code = ch.codeUnitAt(0);
    if (code >= 48 && code <= 57){
      earnedWeight -= 1;
      continue;
    }
    bool isFounded = false;
    for (int c = 1; c <= window; c++) {
      final double distancePenalty = 1.0 - (c / (window + 1));

      if (i + c < target.length && !used[i + c] && target[i + c] == ch) {
        earnedWeight += charImportance * distancePenalty;
        used[i + c] = true;
        isFounded = true;
        break;
      }

      if (i - c >= 0 && i - c < target.length && !used[i - c] && target[i - c] == ch) {
        earnedWeight += charImportance * distancePenalty;
        used[i - c] = true;
        isFounded = true;
        break;
      }
    }
    if(!isFounded) earnedWeight -= k * 2;
  }

  return earnedWeight / maxPossibleWeight;
}

List<String> _getClean(String str) => splitAndClean(str.toLowerCase(), ' ', [',', '.', '(', ')'], toClean: ['/'], toClear: ['-']);