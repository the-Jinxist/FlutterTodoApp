

class TodoModel {
  final int id;
  final String todoTitle;
  final String todoDesc;
  final int timeInMillis;
  final String status;

  TodoModel({this.id, this.todoTitle, this.todoDesc, this.timeInMillis, this.status});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> todoMap = Map();
    todoMap['id'] = id;
    todoMap['todoTitle'] = todoTitle;
    todoMap['todoDesc'] = todoDesc;
    todoMap['timeInMillis'] = timeInMillis;
    todoMap["status"] = status;

    return todoMap;
  }

}