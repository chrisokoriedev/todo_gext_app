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
    final theme = Theme.of(context).colorScheme;

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: PageView(
          controller: controller.pageCtrl,
          onPageChanged: (index) => controller.changeIndex(index),
          children: [
            ListView(
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
            ReportScreen(),
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
                    : theme.primaryContainer,
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
                  color: theme.tertiary,
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
          selectedIconTheme: IconThemeData(color: theme.primary),
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 20.wp),
                  child: const Icon(Icons.grid_4x4_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 20.wp),
                  child: const Icon(Icons.data_usage),
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
