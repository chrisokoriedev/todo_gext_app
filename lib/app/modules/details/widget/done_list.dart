import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class DoneTodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? const Text(AppString.addTodo)
        : ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Text(
                'Completed\t${homeCtrl.doneTodos.length}',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              ...homeCtrl.doneTodos
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
                          Text(element['title'],overflow: TextOverflow.ellipsis,),
                        ]),
                      ))
                  .toList()
            ],
          ));
  }
}
