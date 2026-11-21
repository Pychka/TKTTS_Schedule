import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WheelPicker extends StatefulWidget {
  final int initialMinutes;
  final ValueChanged<int> onChanged;
  final String Function(int value) labelBuilder;

  const WheelPicker({
    super.key,
    required this.initialMinutes,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  State<WheelPicker> createState() => _WheelPickerState();
}

class _WheelPickerState extends State<WheelPicker> {
  final List<int> _values = List.generate(22, (i) => 15 + i * 5);
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    final initialIndex = _values.indexOf(widget.initialMinutes);
    _controller = FixedExtentScrollController(
      initialItem: initialIndex != -1 ? initialIndex : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: CupertinoPicker(
        scrollController: _controller,
        itemExtent: 38,
        magnification: 1.15, 
        useMagnifier: true,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            color: const Color(0x333FA2FF),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onSelectedItemChanged: (int index) {
          widget.onChanged(_values[index]);
        },
        children: _values.map((value) {
          return Center(
            child: Text(
              widget.labelBuilder(value),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
