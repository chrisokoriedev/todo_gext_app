import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';

class ReportScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Obx(() {
          var createdTasks = homeCtrl.getTotalTask();
          var completedTask = homeCtrl.getTotalDoneTask();
          var liveTask = createdTasks - completedTask;
          var getPercent =
              (completedTask / createdTasks * 100).toStringAsFixed(0);
          return Column(
            children: [],
          );
        }),
      ],
    );
  }
}
