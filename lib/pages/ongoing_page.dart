import 'package:flutter/material.dart';

import 'package:todo_app/database/database_repo.dart';
import 'package:todo_app/database/Constants.dart';
import 'package:todo_app/database/todo_model.dart';
import 'package:todo_app/views/todo_view.dart';

class OnGoingPage extends StatefulWidget {
  @override
  _OnGoingPageState createState() => _OnGoingPageState();
}

class _OnGoingPageState extends State<OnGoingPage> {

  DatabaseRepo databaseRepo;

  @override
  void initState() {
    databaseRepo = DatabaseRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: buildTodos()
      ),
    );
  }

  Widget buildTodos(){
    return FutureBuilder<List<TodoModel>>(
      builder: (context, data){
        if(data.hasError){
          return Container(
            child: Center(child: Text("This error happened: ${data.error}",textAlign: TextAlign.center, style: new TextStyle(fontFamily: "Montesserat"),),),
          );
        }else if(data.hasData){
          var listOfTodos = data.data;
          if (listOfTodos.isEmpty){
            return Container(
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image.asset("blank_canvas.svg", width: 70.0, height: 70.0,),
                    SizedBox(height: 20.0,),
                    Text("You neva start any todo yet...",
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 17.0 ),
                    ),
                  ],
                ),
              ),
              ),
            );
          }else{
            print("The list of data is ${listOfTodos[0].status}");
            return ListView.builder(
              itemCount: listOfTodos.length,
              itemBuilder: (context, position) => Dismissible(key: Key("$position"), child: TodoView(todoModel: listOfTodos[position],
                  onCompleteTodoTap: (){

                  },
                  onRemoveTodoTap: (){

                  },
                  onTodoTap: (){

                  },
                ),
              secondaryBackground: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Text("Completed",style: new TextStyle(fontFamily: "Monteserrat", fontSize: 17.0, color: Colors.amber)) ,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Icon(Icons.done, color: Colors.amber, size: 20.0,),
                          SizedBox(width: 10.0,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Text("Deleted",style: new TextStyle(fontFamily: "Monteserrat", fontSize: 17.0, color: Colors.amber)) ,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Icon(Icons.delete_forever, color: Colors.amber, size: 20.0,),
                          SizedBox(width: 10.0,),
                        ],

                      ),
                    )
                  ],
                ),
              ),

              onDismissed: (dismissDirection){
                if(dismissDirection == DismissDirection.endToStart){
                  setState(() {
                    listOfTodos.removeAt(position);
                  });
                  databaseRepo.deleteTodo(listOfTodos[position]);

                }else if(dismissDirection == DismissDirection.startToEnd){
                  setState(() {
                    listOfTodos.removeAt(position);
                  });
                  TodoModel todoModel = listOfTodos[position];
                  todoModel.status = Constants.COMPLETED;
                  databaseRepo.updateTodo(todoModel);
                }
              }
              )

            );
          }
        }

        return Center(child: CircularProgressIndicator(),);
      },
      future: databaseRepo.queryOnGoingTodos(),
    );
  }

  Future<void> updateTodoAndReload (TodoModel currentTodo) async {
    currentTodo.status = Constants.COMPLETED;

    await databaseRepo.updateTodo(currentTodo);
    buildTodos();
  }
}

