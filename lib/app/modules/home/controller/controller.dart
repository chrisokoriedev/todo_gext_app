import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/data/services/storage/respository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final tasks = <TaskModel>[].obs;
  final formKey = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final editController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  @override
  void onClose() {
    super.onClose();
    tasks.close();
  }

  void chnageChipdIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(TaskModel task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }
}
