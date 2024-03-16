import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class DoingTodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTask.isEmpty && homeCtrl.doneTask.isEmpty
        ? const Column(
            children: [Placeholder(), Text(AppString.addTodo)],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTask.map((element) => Row(children: [
                    SizedBox(
                      width: 20.wp,
                      height: 20.hp,
                      child: Checkbox(
                        value: element['done'],
                        onChanged: (value) {},
                      ),
                    ),
                    Text(element['title']),
                  ]))
            ],
          ));
  }
}
