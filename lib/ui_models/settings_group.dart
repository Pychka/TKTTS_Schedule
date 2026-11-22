import 'package:flutter/material.dart';

class SettingsGroup {
  final String title;
  final IconData icon;
  final Widget? targetScreen;
  final List<Widget> widgets;

  const SettingsGroup({
    required this.title,
    required this.icon,
    required this.widgets,
    this.targetScreen,
  });
}