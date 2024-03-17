import 'package:get/get.dart';
import 'package:todo_gext_app/app/data/provider/tasks/provider.dart';
import 'package:todo_gext_app/app/data/services/storage/respository.dart';

import 'controller.dart';

class HomeBiniding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
          taskRepository: TaskRepository(
        taskProvider: TaskProvider(),
      )),
    );
  }
}
