import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/extensions.dart';
import 'package:todo_gext_app/app/modules/home/controller/controller.dart';

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
                    onPressed: () => Get.back(), icon: const Icon(Icons.close)),
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: () {},
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 14.sp),
                    ))
              ],
            ),
            Text(
              'New Task',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            TextFormField(
              controller: homeCtrl.editController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter  todo item';
                }
                return null;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[100]!))),
            ),
            SizedBox(height: 5.wp),
            Text(
              "Add to ",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            ...homeCtrl.tasks.map((element) {
              print(element);
              print('element');
              return Row(
                  children: [
                    Icon(
                      IconData(element.icon, fontFamily: "MaterialIcons"),
                      color: HexColor.fromHex(element.color),
                    ),
                    Text(element.title),
                  ],
                );
            }).toList()
          ],
        ),
      ),
    );
  }
}
