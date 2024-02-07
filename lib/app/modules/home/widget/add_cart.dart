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
    final icons = getIcons();
    var squareWidth = Get.width - 12.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.wp),
      child: InkWell(
          onTap: () {},
          child: DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [8, 5],
              child: Center(
                  child: Icon(
                Icons.add,
                size: 10.sp,
                color: Colors.grey,
              )))),
    );
  }
}
