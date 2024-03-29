import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/modules/details/view.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final TaskModel task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Color color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.wp;
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todoList ?? []);
        Get.to(DetailScreen());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.wp),
        decoration: BoxDecoration(color: theme.primaryContainer, boxShadow: [
          BoxShadow(
              color: theme.shadow,
              blurRadius: 7,
              offset: const Offset(0, 7))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
                totalSteps:
                    homeCtrl.isTodosEmpty(task) ? 1 : task.todoList!.length,
                currentStep: homeCtrl.isTodosEmpty(task)
                    ? 0
                    : homeCtrl.getDoneTodo(task),
                padding: 0,
                size: 5,
                selectedGradientColor: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.6), color]),
                unselectedGradientColor: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[200]!, Colors.grey[200]!])),
            Padding(
              padding: EdgeInsets.all(6.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(height: 6.wp),
                  Text(
                    task.title,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                  SizedBox(height: 2.wp),
                  Text(
                    '${task.todoList != null ? task.todoList!.length : 0} Task',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
