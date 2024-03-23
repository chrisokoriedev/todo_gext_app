import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 4.wp, vertical: 2.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14.sp),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.wp),
                  child: const Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildStatus(Colors.green, liveTask, 'Live Task'),
                    buildStatus(Colors.orange, completedTask, 'Completed'),
                    buildStatus(Colors.blue, createdTasks, 'Created'),
                  ],
                ),
                SizedBox(height: 20.wp),
                Center(
                  child: UnconstrainedBox(
                    child: SizedBox(
                      width: 80.wp,
                      height: 80.wp,
                      child: CircularStepProgressIndicator(
                        totalSteps: createdTasks == 0 ? 1 : createdTasks,
                        currentStep: completedTask,
                        stepSize: 10,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        selectedStepSize: 18,
                        roundedCap: (_, __) => true,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ],
    );
  }

  buildStatus(Color color, int number, String sub) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle_outlined, color: color),
        SizedBox(width: 2.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number.toString(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 2.wp),
            Text(
              sub,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}
