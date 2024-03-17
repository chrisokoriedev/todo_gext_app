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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.wp, vertical: 2.wp),
                child: Text(
                  'Completed\t${homeCtrl.doneTodos.length}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ),
              ...homeCtrl.doneTodos
                  .map((element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) =>
                            homeCtrl.deleteDoneTodo(element['title']),
                        background: Container(
                          color: Colors.red[700],
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5.wp),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.wp, horizontal: 5.wp),
                          child: Row(children: [
                             Icon(Icons.check_box, color: Colors.blue,size: 15.sp,),
                            SizedBox(width: 3.wp),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ]),
                        ),
                      ))
                  .toList()
            ],
          ));
  }
}
