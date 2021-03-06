import 'package:flutter/material.dart';
import 'package:todo_app/database/todo_model.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();


  final TodoModel todoModel;

  TodoView({this.todoModel});

}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: Card(
            elevation: 10.0,
            child: Padding(
              padding: EdgeInsets.all(10.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.work, color: Colors.black, size: 17.0,),
                  SizedBox(width: 20.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(generateTodoTitle(widget.todoModel.todoTitle), textAlign: TextAlign.center, style: new TextStyle(
                          fontFamily: "Montesserat", fontWeight: FontWeight.bold, fontSize: 17.0
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(generateTodoDesc(widget.todoModel.todoDesc), textAlign: TextAlign.center, style: new TextStyle(
                          fontFamily: "Montesserat", fontSize: 14.0
                      ),
                      ),
                    ],
                  ),
                ],

              ),

            ),
          ),
        )
    );
  }

  String generateTodoDesc(String todoDesc){
    if(todoDesc != null){
      if (todoDesc.length > 40){
        return todoDesc.substring(0, 40) + "...";
      }else{
        return todoDesc;
      }
    }else{
      return "This description no dey o";
    }
  }

  String generateTodoTitle(String todoTitle){
    if(todoTitle != null){
      if (todoTitle.length > 30){
        return todoTitle.substring(0, 30) + "...";
      }else{
        return todoTitle;
      }
    }else{
      return "This title no dey o";
    }
  }
}
