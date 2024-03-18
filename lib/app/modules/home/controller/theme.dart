import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    currentTheme.value =
        ThemeMode.values[storage.read('themeMode') ?? ThemeMode.system.index];
        debugPrint(currentTheme.value.toString());
  }

  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    storage.write('themeMode', currentTheme.value.index);
  }
}
