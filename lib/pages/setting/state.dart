import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingState {
  Rx<String> gensui = "跟随系统".obs;
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;
}
