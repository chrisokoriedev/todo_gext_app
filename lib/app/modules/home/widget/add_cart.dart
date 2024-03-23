import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/core/value/colors.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/modules/home/controller/theme.dart';
import 'package:todo_gext_app/app/widget/icons.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final themeCtrl = Get.find<ThemeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final iconData = getIcons();
    var squareWidth = Get.width - 12.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.wp),
      child: InkWell(
          onTap: () {
            Get.defaultDialog(
                radius: 10,
                title: AppString.taskType,
                titleStyle:
                    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                cancel: ElevatedButton.icon(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: Text(
                      AppString.cancel,
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    )),
                confirm: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        int iconPicked =
                            iconData[homeController.chipIndex.value]
                                .icon!
                                .codePoint;
                        String color = iconData[homeController.chipIndex.value]
                            .color!
                            .toHex();
                        var task = TaskModel(
                            title: homeController.editController.text,
                            icon: iconPicked,
                            color: color);
                        Get.back();
                        homeController.addTask(task)
                            ? EasyLoading.showSuccess(AppString.createSuccess)
                            : EasyLoading.showError(AppString.duplicateTask);
                      }
                      homeController.chipIndex(0);
                      homeController.editController.clear();
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: Text(
                      AppString.create,
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    )),
                content: Form(
                    key: homeController.formKey,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.wp, vertical: 5.hp),
                            child: TextFormField(
                                controller: homeController.editController,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return AppString.enterTaskTitle;
                                  }
                                  return null;
                                })),
                        Wrap(
                            spacing: 2.wp,
                            children: iconData
                                .map((e) => Obx(() {
                                      final index = iconData.indexOf(e);
                                      return ChoiceChip(
                                          selectedColor: theme.tertiary,
                                          elevation: 0,
                                          side: BorderSide.none,
                                          label: e,
                                          onSelected: (bool selected) {
                                            homeController.chipIndex.value =
                                                selected ? index : 0;
                                          },
                                          selected:
                                              homeController.chipIndex.value ==
                                                  index);
                                    }))
                                .toList())
                      ],
                    )));
            homeController.chipIndex(0);
            homeController.editController.clear();
          },
          child: DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [8, 5],
              child: Center(
                  child: Icon(
                Icons.add,
                size: 10.wp,
                color: Colors.grey,
              )))),
    );
  }
}
