import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/details/widget/done_list.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

import 'widget/doing_list.dart';

class DetailScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void submit() {
      if (homeCtrl.formKey.currentState!.validate()) {
        var success = homeCtrl.addTodo(homeCtrl.editController.text);
        if (success) {
          EasyLoading.showSuccess(AppString.todoItemAdded);
        } else {
          EasyLoading.showSuccess(AppString.todoItemExist);
        }
      }
      homeCtrl.updateTodo();
      homeCtrl.changeTask(null);
      homeCtrl.editController.clear();
    }

    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        homeCtrl.updateTodo();
        homeCtrl.changeTask(null);
        homeCtrl.editController.clear();
      },
      child: Scaffold(
          body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.wp, vertical: 3.wp),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        onPressed: () {
                          Get.back();
                          homeCtrl.updateTodo();
                          homeCtrl.changeTask(null);
                          homeCtrl.editController.clear();
                        },
                      )),
                  SizedBox(height: 2.hp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.wp),
                    child: Row(
                      children: [
                        Icon(
                            IconData(task.icon,
                                fontFamily: AppString.materialIcons),
                            color: color),
                        SizedBox(width: 2.wp),
                        Text(
                          task.title,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 3.hp),
                  Obx(() {
                    var totalTodos =
                        homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.wp),
                      child: Row(
                        children: [
                          Text('$totalTodos Task'),
                          SizedBox(width: 3.wp),
                          Expanded(
                              child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: homeCtrl.doneTodos.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [color.withOpacity(0.5), color]),
                            unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.grey[300]!,
                                  Colors.grey[300]!,
                                ]),
                          ))
                        ],
                      ),
                    );
                  }),
                  TextFormField(
                    controller: homeCtrl.editController,
                    textInputAction: TextInputAction.done,
                    autofocus: true,
                    onFieldSubmitted: (value) {
                      submit();
                      homeCtrl.editController.clear();
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      prefixIcon: Icon(Icons.check_box_outline_blank,
                          color: Colors.grey[400]),
                      suffixIcon: IconButton(
                          onPressed: () {
                            submit();
                            homeCtrl.editController.clear();
                          },
                          icon: const Icon(Icons.done)),
                    ),
                    validator: (text) {
                      if (text!.trim().isEmpty) {
                        return AppString.enterTodoItem;
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            DoingTodoList(),
            DoneTodoList(),
          ],
        ),
      )),
    );
  }
}
