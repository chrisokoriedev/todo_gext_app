import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/icons.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                title: 'Task Type',
                titleStyle:
                    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
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
                                    return 'Enter task title';
                                  }
                                  return null;
                                })),
                        Wrap(
                            spacing: 2.wp,
                            children: iconData
                                .map((e) => Obx(() {
                                      final index = iconData.indexOf(e);
                                      return ChoiceChip(
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
