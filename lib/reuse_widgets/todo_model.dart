import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)

class TodoModel{
  @HiveField(0)
  final String? title;
  @HiveField(1)

  final String ? describe;
  @HiveField(2)

  late DateTime? createdDate;
  @HiveField(3)

  late bool? completed;
  @HiveField(4)
  late DateTime? createDay;
  final int? id;

  TodoModel({
    this.id,
    this.completed,this.createdDate,this.title,this.createDay,this.describe
});
}

