import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_gext_app/app/core/utlls/keys.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/data/services/storage/services.dart';

class TaskProvider {
  final StorageService _storageService = Get.find<StorageService>();
  List<TaskModel> readTask() {
    var tasks = <TaskModel>[];
    jsonDecode(
      _storageService.read(taskKey).toString(),
    ).forEach((e) => tasks.add(TaskModel.fromJson(e)));
    return tasks;
  }

  void wirteTask(List<TaskModel> task) {
    _storageService.write(taskKey, jsonEncode(task));
  }
}
