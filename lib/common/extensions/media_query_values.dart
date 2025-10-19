import 'package:flutter/material.dart';

/// Доступ к MediaQuery прямо из контекста
extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension ScaleUtils on BuildContext {
  double scaleW(double size) => size * screenWidth / 360;
  double scaleH(double size) => size * screenHeight / 800;
  double scaleSp(double fontSize) => fontSize * screenWidth / 360;
}