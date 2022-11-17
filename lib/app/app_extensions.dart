import 'dart:math' as math;

import 'package:flutter/material.dart';

extension FocusNodeX on FocusNode {
  void selectAllOnFocus(TextEditingController controller) {
    addListener(() {
      if (hasFocus) {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      }
    });
  }

  void doOnFocus(VoidCallback voidCallback) {
    addListener(() {
      if (hasFocus) {
        voidCallback();
      }
    });
  }

  void doOnFocusLost(VoidCallback voidCallback) {
    addListener(() {
      if (!hasFocus) {
        voidCallback();
      }
    });
  }
}

extension ColorX on Color {
  MaterialColor generateMaterialColor() {
    return MaterialColor(value, {
      50: _tintColor(this, 0.9),
      100: _tintColor(this, 0.8),
      200: _tintColor(this, 0.6),
      300: _tintColor(this, 0.4),
      400: _tintColor(this, 0.2),
      500: this,
      600: _shadeColor(this, 0.1),
      700: _shadeColor(this, 0.2),
      800: _shadeColor(this, 0.3),
      900: _shadeColor(this, 0.4),
    });
  }

  int _tintValue(int value, double factor) =>
      math.max(0, math.min((value + ((255 - value) * factor)).round(), 255));

  Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1);

  int _shadeValue(int value, double factor) =>
      math.max(0, math.min(value - (value * factor).round(), 255));

  Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1);
}