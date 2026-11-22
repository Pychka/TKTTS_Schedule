import 'dart:ui';
import 'package:flutter/material.dart';

class WheelPickerV2<T> extends StatefulWidget {
  final T initialValue;
  final List<T> values;
  final Color activeTextColor;
  final Color baseTextColor;
  final double fontSize;
  final ValueChanged<T> onChanged;
  final String Function(T value) labelBuilder;

  const WheelPickerV2({
    super.key,
    required this.initialValue,
    required this.values,
    required this.onChanged,
    required this.labelBuilder,
    this.fontSize = 16,
    this.activeTextColor = Colors.white,
    this.baseTextColor = Colors.black,
  });

  @override
  State<WheelPickerV2<T>> createState() => WheelPickerV2State<T>();
}

class WheelPickerV2State<T> extends State<WheelPickerV2<T>> {
  late final List<GlobalKey> _itemKeys = List.generate(widget.values.length, (_) => GlobalKey());
  late T selectedValue;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.values.contains(widget.initialValue)
        ? widget.initialValue
        : widget.values.first;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected(animate: false);
    });
  }

  void _scrollToSelected({bool animate = true}) {
    final index = widget.values.indexOf(selectedValue);
    if (index == -1) return;

    final itemContext = _itemKeys[index].currentContext;
    if (itemContext != null) {
      Scrollable.ensureVisible(
        itemContext,
        alignment: 0.5, // Центрируем выбранный элемент
        duration: animate ? const Duration(milliseconds: 250) : Duration.zero,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: List.generate(
              widget.values.length,
              (index) {
                final value = widget.values[index];
                final isSelected = value == selectedValue;
                return Card(
                  key: _itemKeys[index],
                  color: isSelected ? const Color(0xFF4BA8FF) : Colors.transparent,
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    splashColor: const Color(0x6C71BAFF),
                    hoverColor: const Color(0x6CC9E5FF),
                    highlightColor: const Color(0x6CC9E5FF),
                    onTap: () {
                      setState(() {
                        selectedValue = value;
                      });
                      widget.onChanged(value);
                      _scrollToSelected();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text(
                        widget.labelBuilder(value),
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                          color: isSelected ? widget.activeTextColor : widget.baseTextColor,
                          fontSize: widget.fontSize,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
