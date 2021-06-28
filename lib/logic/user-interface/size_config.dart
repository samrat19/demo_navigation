import 'package:flutter/material.dart';

double ?screenHeight;
double ?screenWidth;

class SizeConfig {
  static double ?_screenWidth;
  static double ?_screenHeight;

  static final SizeConfig _singleton = new SizeConfig._internal();

  factory SizeConfig() {
    return _singleton;
  }

  SizeConfig._internal();

  void init(BoxConstraints boxConstraints, Orientation orientation) {
    _screenWidth = boxConstraints.maxWidth;
    _screenHeight = boxConstraints.maxHeight;
    if (orientation == Orientation.landscape) {
      _screenWidth = boxConstraints.maxHeight;
      _screenHeight = boxConstraints.maxWidth;
    }
    screenHeight = _screenHeight;
    screenWidth = _screenWidth;
  }
}
