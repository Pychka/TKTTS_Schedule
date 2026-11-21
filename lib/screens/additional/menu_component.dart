import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tktts_schedule/nav_item.dart';
import 'package:tktts_schedule/screens/additional/glass_container.dart';

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
    double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double spacing = max(25.0 - (5 * max((widget.navItems.length - 2), 0)), 5);
    double activeWeight = 1 + (1 / (widget.navItems.length + 1));
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
        child: GlassContainer(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final count = widget.navItems.length;
                final totalSpacing = spacing * (count - 1);
                final availableWidth = constraints.maxWidth - totalSpacing;
                final totalWeight = activeWeight + (count - 1);
                final unitWidth = availableWidth / totalWeight;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: spacing,
                  children: List.generate(
                    count,
                    (index) {
                      final item = widget.navItems[index];
                      final isSelected = _selectedIndex == index;
                      final itemWidth = isSelected ? unitWidth * activeWeight : unitWidth;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          widget.onTap(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          width: itemWidth,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xB73FA2FF)
                                : const Color(0xEEfafcff),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: isSelected
                                ? [
                                    const BoxShadow(
                                      color: Color(0x20000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    )
                                  ]
                                : [],
                          ),
                          child: Icon(
                            isSelected ? item.activeIcon : item.baseIcon,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.8)
                                : Colors.blueGrey,
                            size: isSelected ? 25 : 22,
                            shadows: [
                              if(isSelected)
                                Shadow(
                                  offset: Offset(0, 1.5),
                                  blurRadius: 1.5,
                                  color: const Color(0xDC126CC0),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            )
          )
        )
      )
    );
  }
}