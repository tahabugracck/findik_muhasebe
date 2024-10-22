import 'package:findik_muhasebe/widgets/theme_setting.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeSetting.standardTheme; // Varsayılan tema

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void setDarkTheme() {
    _currentTheme = ThemeSetting.darkTheme; //siyah tema
    notifyListeners();
  }

  void setWhiteTheme() {
    _currentTheme = ThemeSetting.whiteTheme; //beyaz tema
    notifyListeners();
  }

  void setStandardTheme() {
    _currentTheme = ThemeSetting.standardTheme; //standart tema
    notifyListeners();
  }
}
