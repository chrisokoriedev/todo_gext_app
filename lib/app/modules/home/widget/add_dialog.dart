import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';
import 'package:todo_gext_app/app/widget/string_const.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.wp, vertical: 5.wp),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editController.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(Icons.close)),
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.task.value == null) {
                          EasyLoading.showError(AppString.enterTaskType);
                        }
                      }
                    },
                    child: Text(
                      AppString.done,
                      style: TextStyle(fontSize: 14.sp),
                    ))
              ],
            ),
            Text(
              AppString.newTask,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: homeCtrl.editController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.enterTodoItem;
                } else {
                  var success = homeCtrl.updateTask(
                      homeCtrl.task.value!, homeCtrl.editController.text);
                  if (success) {
                    EasyLoading.showSuccess(AppString.todoItemAdded);
                    Get.back();
                    homeCtrl.changeTask(null);
                  } else {
                    EasyLoading.showInfo(AppString.todoItemExist);
                    homeCtrl.editController.clear();
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[100]!))),
            ),
            SizedBox(height: 5.wp),
            Text(AppString.addTo,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon,
                                        fontFamily: AppString.materialIcons),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  Text(element.title),
                                ],
                              ),
                              if (homeCtrl.task.value == element)
                                const Icon(Icons.check, color: Colors.blue)
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
