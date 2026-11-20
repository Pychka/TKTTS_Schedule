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
    this.backgroundColor = const Color(0x6C71BAFF),
    this.borderColor = const Color(0x6CD3EAFF),
    this.blurSigma = 4.5,
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
          child: child,
        ),
      ),
    );
  }
}
