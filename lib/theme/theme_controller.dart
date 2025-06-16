import 'package:flutter/cupertino.dart';

class ThemeController {
  static ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  static void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
