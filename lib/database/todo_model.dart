

class TodoModel {
  int id;
  String todoTitle;
  String todoDesc;
  int timeInMillis;
  String status;

  TodoModel({this.id, this.todoTitle, this.todoDesc, this.timeInMillis, this.status});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> todoMap = Map();
    todoMap['id'] = this.id;
    todoMap['todoTitle'] = this.todoTitle;
    todoMap['todoDesc'] = this.todoDesc;
    todoMap['timeInMillis'] = this.timeInMillis;
    todoMap["status"] = this.status;

    return todoMap;
  }

  String toString(){
    return "The todo Model is as follows: Status ${this.status}";
  }

  bool isComplete(){
    if(this.status.isNotEmpty && this.todoTitle.isNotEmpty && this.todoDesc.isNotEmpty
    && this.timeInMillis != null && this.id != null && this.status != null && this.todoTitle != null && this.todoDesc != null){
      return true;
    }else{
      return false;
    }

  }


}