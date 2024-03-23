import 'package:flutter/foundation.dart';
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
  final currentIndex = 0.obs;
  final deleting = false.obs;
  final editController = TextEditingController();
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changeIndex(int index) {
    currentIndex.value = index;
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
    doingTodos.clear();
    doneTodos.clear();
    for (int element = 0; element < select.length; element++) {
      var todo = select[element];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodo() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copywith(todoList: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    var index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void unCheckTodo(String title) {
    var doneTodo = {'title': title, 'done': true};
    var index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    var newDoingTodo = {'title': title, 'done': false};
    doingTodos.add(newDoingTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  deleteDoneTodo(String title) {
    var doneTodo = {'title': title, 'done': true};
    var index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(TaskModel task) {
    return task.todoList == null || task.todoList!.isEmpty;
  }

  int getDoneTodo(TaskModel task) {
    var res = 0;
    for (var i = 0; i < task.todoList!.length; i++) {
      if (task.todoList![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }
}
