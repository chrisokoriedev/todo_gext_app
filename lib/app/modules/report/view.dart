import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.wp, vertical: 5.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
