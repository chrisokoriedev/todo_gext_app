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
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? const Column(
            children: [Placeholder(), Text(AppString.addTodo)],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.wp, horizontal: 5.wp),
                        child: Row(children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey[200]!),
                              value: element['done'],
                              onChanged: (value) {
                                homeCtrl.doneTodo(element['title']);
                              },
                            ),
                          ),
                          SizedBox(width: 3.wp),
                          Text(element['title']),
                        ]),
                      ))
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Container(
                    padding: EdgeInsets.only(left: 10.wp),
                    child: const Divider(thickness: 2)),
            ],
          ));
  }
}
