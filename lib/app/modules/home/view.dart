import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/value/colors.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/widget/add_cart.dart';

import 'widget/task_card.dart';

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(4.wp),
          children: [
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...controller.tasks
                      .map(
                        (element) => LongPressDraggable(
                          data: element,
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDeleting(false),
                            onDragEnd: (_) => controller.changeDeleting(true),
                            feedback: Opacity(
                                opacity: 0.4, child: TaskCard(task: element)),
                            child: TaskCard(task: element)),
                      )
                      .toList(),
                  AddCard()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => DragTarget<TaskModel>(
        onAccept: (TaskModel task){
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted Task');
        },
        builder: (_,__,___) {
          return FloatingActionButton(
                backgroundColor:
                    controller.deleting.value ? Colors.red[400] : Colors.purple[100],
                onPressed: () {},
                child: Icon(controller.deleting.value ? Icons.delete : Icons.add,color: Colors.white,),
              );
        }
      )),
    );
  }
}
