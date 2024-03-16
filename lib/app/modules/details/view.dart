import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class DetailScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
    var totalTodos = homeCtrl.doingTask.length + homeCtrl.doneTask.length;
    return Scaffold(
        body: Form(
      key: homeCtrl.formKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.wp, vertical: 3.wp),
            child: Column(
              children: [
                const Align(alignment: Alignment.topLeft, child: BackButton()),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.wp),
                  child: Row(
                    children: [
                      Text('$totalTodos Task'),
                      SizedBox(width: 3.wp),
                      Expanded(
                          child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.doneTask.length,
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
                ),
                TextFormField(
                  controller: homeCtrl.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!)),
                    prefixIcon: Icon(Icons.check_box_outline_blank,
                        color: Colors.grey[400]),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (homeCtrl.formKey.currentState!.validate()) {
                            var success =
                                homeCtrl.addTodo(homeCtrl.editController.text);
                            if (success) {
                              EasyLoading.showSuccess(AppString.todoItemAdded);
                            } else {
                              EasyLoading.showSuccess(AppString.todoItemExist);
                            }
                          }
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
        ],
      ),
    ));
  }
}
