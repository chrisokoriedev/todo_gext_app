import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/data/services/storage/respository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final tasks = <TaskModel>[].obs;
  final task = Rx<TaskModel?>(null);
  final formKey = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final editController = TextEditingController();
  final doingTask = <dynamic>[];
  final doneTask = <dynamic>[];
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    tasks.close();
    super.onClose();
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  void chnageChipdIndex(int value) {
    chipIndex.value = value;
  }

  void changeTask(TaskModel? select) {
    task.value = select;
  }

  updateTask(TaskModel taskModel, String taskItem) {
    var todos = taskModel.todoList ?? [];
    if (containTodo(todos, taskItem)) {
      return false;
    }
    var todo = {'title': taskItem, 'done': false};
    todos.add(todo);
    var newTask = taskModel.copywith(todoList: todos);
    int oldIndex = tasks.indexOf(taskModel);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, taskItem) {
    return todos.any((element) => element['title'] == taskItem);
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(TaskModel task) {
    tasks.remove(task);
  }

  bool addTask(TaskModel task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeTodos(List<dynamic> select) {
    doingTask.clear();
    doneTask.clear();
    for (int element = 0; element < select.length; element++) {
      var todo = select[element];
      var status = todo['done'];
      if (status == true) {
        doneTask.add(todo);
      } else {
        doingTask.add(todo);
      }
    }
  }

  addTodo( String title) {}
}
