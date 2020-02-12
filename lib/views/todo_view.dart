import 'package:flutter/material.dart';
import 'package:todo_app/database/todo_model.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();

  final void onTodoTap;
  final void onRemoveTodoTap;
  final void onCompleteTodoTap;
  final TodoModel todoModel;

  TodoView({this.onTodoTap, this.onRemoveTodoTap, this.onCompleteTodoTap, this.todoModel});

}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTodoTap,
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
                    children: <Widget>[
                      Text(widget.todoModel.todoTitle != null ? widget.todoModel.todoTitle : "This title is null", textAlign: TextAlign.center, style: new TextStyle(
                          fontFamily: "Montesserat", fontWeight: FontWeight.bold, fontSize: 17.0
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(widget.todoModel.todoDesc != null ? widget.todoModel.todoDesc : "This description is null", textAlign: TextAlign.center, style: new TextStyle(
                          fontFamily: "Montesserat", fontSize: 14.0
                      ),
                      ),
                    ],
                  ),
                  //TODO: THIS SHIT DOESN'T WORK MEN!
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => widget.onCompleteTodoTap,
                            child: Icon(Icons.done, size: 17.0, color: Colors.amber, ),
                          ),
                          SizedBox(width: 10.0,),
                          GestureDetector(
                            onTap: () => widget.onRemoveTodoTap,
                            child: Icon(Icons.remove, size: 17.0, color: Colors.amber, ),
                          )
                        ],
                      )
                  )
                ],

              ),

            ),
          ),
        )
    );
  }
}
