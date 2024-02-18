import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final TaskModel task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Color color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.wp),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey[300]!, blurRadius: 7, offset: const Offset(0, 7))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              padding: 0,
              size: 5,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white54])),
          Icon(
            IconData(
              task.icon,
              fontFamily: 'MaterialIcons',
            ),
            color: color,
          ),
          Text(
            task.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
          ),
          Text('${task.todoList!.length} Task'),
        ],
      ),
    );
  }
}
