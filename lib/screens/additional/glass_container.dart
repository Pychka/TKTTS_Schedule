import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double blurSigma;

  GlassContainer({
    super.key,
    required this.child,
    BorderRadius? borderRadius,
    this.backgroundColor = const Color(0x7C71BAFF),
    this.borderColor = const Color(0x7CD3EAFF),
    this.blurSigma = 5.5,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Material(
            type: MaterialType.transparency, 
            child: child,
          ),
        ),
      ),
    );
  }
}
