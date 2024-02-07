class TaskModel {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todoList;
  TaskModel(
      {required this.title,
      required this.icon,
      required this.color,
      this.todoList});

  TaskModel copywith(
          {String? title, int? icon, String? color, List<dynamic>? todoList}) =>
      TaskModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todoList: todoList ?? this.todoList,
      );
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'],
        icon: json['icon'],
        color: json['color'],
        todoList: json['todoList'],
      );
  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'todoList': todoList,
      };
}
