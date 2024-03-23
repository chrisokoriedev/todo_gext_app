import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/theme.dart';
import 'package:todo_gext_app/app/modules/home/widget/add_cart.dart';
import 'package:todo_gext_app/app/modules/home/widget/add_dialog.dart';
import 'package:todo_gext_app/app/modules/report/view.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

import 'widget/task_card.dart';

class MyHomePage extends GetView<HomeController> {
  final ThemeController themeController = Get.find();
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.currentIndex.value == 0
                ? AppString.myTask
                : AppString.report,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            Obx(
              () => IconButton(
                  onPressed: () {
                    themeController.switchTheme();
                    Get.changeThemeMode(themeController.currentTheme.value);
                  },
                  icon: Icon(
                      themeController.currentTheme.value == ThemeMode.light
                          ? Icons.light_mode
                          : Icons.dark_mode)),
            ),
          ],
        ),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            SafeArea(
              child: ListView(
                padding: EdgeInsets.all(4.wp),
                children: [
                  GridView.count(
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
                                onDragEnd: (_) =>
                                    controller.changeDeleting(true),
                                feedback: Opacity(
                                    opacity: 0.4,
                                    child: TaskCard(task: element)),
                                child: TaskCard(task: element)),
                          )
                          .toList(),
                      controller.tasks.length <= 10
                          ? AddCard()
                          : const SizedBox.shrink()
                    ],
                  ),
                ],
              ),
            ),
            const ReportScreen(),
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: DragTarget<TaskModel>(
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor: controller.deleting.value
                    ? Colors.red[400]
                    : Colors.purple[100],
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(AddDialog(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 450));
                  } else {
                    EasyLoading.showInfo(AppString.createTaskType);
                  }
                },
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          },
          onAccept: (TaskModel task) {
            controller.deleteTask(task);
            controller.task.refresh();
            EasyLoading.showSuccess(AppString.deletedTask);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => controller.changeIndex(index),
          currentIndex: controller.currentIndex.value,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_4x4_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.data_usage), label: 'Report'),
          ],
        ),
      ),
    );
  }
}
