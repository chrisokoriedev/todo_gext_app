import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class DetailScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
    var totalTodos = homeCtrl.doingTask.length + homeCtrl.doneTask.length;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.wp, vertical: 3.wp),
          child: Column(
            children: [
              const Align(alignment: Alignment.topLeft, child: BackButton()),
              SizedBox(height: 2.hp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.wp),
                child: Row(
                  children: [
                    Icon(
                        IconData(task.icon,
                            fontFamily: AppString.materialIcons),
                        color: color),
                    SizedBox(width: 2.wp),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.hp),
              Row(
                children: [Text('$totalTodos Task')],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
