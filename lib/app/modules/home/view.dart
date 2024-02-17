import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(4.wp),
          children: [
            Text(
              'My tasks',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            GridView.count(
              crossAxisCount: 2,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                TaskCard(
                  task: const TaskModel(
                      title: 'hey', icon: 0xe59c, color: '0xff42A5F5'),
                ),
                AddCard()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
