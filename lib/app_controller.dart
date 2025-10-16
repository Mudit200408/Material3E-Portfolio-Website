import 'package:flutter/material.dart';

enum AppStyle { material, cupertino }

class AppController extends ChangeNotifier {
  var _appStyle = AppStyle.material;
  AppStyle get appStyle => _appStyle;

  void setStyle(AppStyle style) {
    _appStyle = style;
    notifyListeners();
  }
}
