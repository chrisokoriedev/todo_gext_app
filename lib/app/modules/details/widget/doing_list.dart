import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';

class DoingTodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTask.isEmpty && homeCtrl.doneTask.isEmpty
        ? const Placeholder()
        : const Text('hey'));
  }
}
