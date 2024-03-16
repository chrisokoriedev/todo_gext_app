import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class DoneTodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? const Column(
            children: [Placeholder(), Text(AppString.addTodo)],
          )
        : ListView(
            shrinkWrap: true,
            children: const [],
          ));
  }
}
