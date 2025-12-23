import 'package:flutter/material.dart';

class GlobalWidgets {
  // Custom Yellow Underline
  static Widget customDivider({
    required double height,
    required double width,
    required Color color,
  }) {
    return Container(height: height, width: width, color: color);
  }
}