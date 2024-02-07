import 'package:todo_gext_app/app/data/model/task.dart';
import 'package:todo_gext_app/app/data/provider/tasks/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});
  List<TaskModel> readTask() => taskProvider.readTask();
  void writeTask(List<TaskModel> tasks) => taskProvider.wirteTask(tasks);
}
