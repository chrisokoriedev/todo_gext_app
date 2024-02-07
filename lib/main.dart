import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_gext_app/app/data/services/storage/services.dart';
import 'package:todo_gext_app/app/modules/home/controller/binding.dart';
import 'package:todo_gext_app/app/modules/home/view.dart';

Future<void> main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      initialBinding: HomeBiniding(),
      builder: EasyLoading.init(),
    );
  }
}
