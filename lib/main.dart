import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_gext_app/app/data/services/storage/services.dart';
import 'package:todo_gext_app/app/modules/home/controller/binding.dart';
import 'package:todo_gext_app/app/modules/home/view.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

import 'app/core/value/theme.dart';
import 'app/modules/home/controller/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.currentTheme.value,
      home: MyHomePage(),
      initialBinding: HomeBiniding(),
      builder: EasyLoading.init(),
    );
  }
}
