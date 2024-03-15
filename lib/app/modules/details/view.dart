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

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(3.wp),
          child: const Align(alignment: Alignment.topLeft, child: BackButton()),
        ),
        Row(
          children: [
            Icon(IconData(task.icon, fontFamily: AppString.materialIcons),
                color: color),
          ],
        )
      ],
    ));
  }
}
