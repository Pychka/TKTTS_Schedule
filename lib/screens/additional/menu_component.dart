import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tktts_schedule/nav_item.dart';

class MenuComponent extends StatefulWidget{
  final List<NavItem> navItems;
  final ValueChanged<int> onTap;
  const MenuComponent({
    required this.navItems,
    required this.onTap,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: 
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xC0dceeff), 
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0x76FFFFFF), 
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: List.generate(
                  widget.navItems.length,
                  (index) {
                    final item = widget.navItems[index];
                    final isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        _selectedIndex = index;
                        widget.onTap(index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 32.0 : 24.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF8cafff) : Color(0xEEfafcff),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Color.fromARGB(20, 0, 0, 0),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : [],
                          ),
                        child: Icon(
                          isSelected ? item.activeIcon : item.baseIcon,
                          color: (isSelected ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}