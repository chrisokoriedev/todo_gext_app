import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(4.0.wp),
          children: [
            Text(
              'My tasks',
              style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
