import 'package:flutter/material.dart';

import 'package:todo_app/database/database_repo.dart';
import 'package:todo_app/database/Constants.dart';
import 'package:todo_app/database/todo_model.dart';
import 'package:todo_app/views/todo_view.dart';
import 'view_todo_page.dart';

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
                    SizedBox(height: 70,),
                    Image.asset('assets/images/note.png', width: 200.0, height: 200.0, scale: 1, colorBlendMode: BlendMode.darken, fit: BoxFit.fill,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("You don't have any todos. Click the + button to create one.",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 17.0 ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Swipe right to complete a todo, Swipe left to delete one. Tap for more options",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 13.0 ),
                      ),
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
              itemBuilder: (context, position) =>
                  Dismissible(
                    key: UniqueKey(),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTodoPage(model: listOfTodos[position],)));
                      },
                      child: TodoView(todoModel: listOfTodos[position],
                  ),
                    ),
              background: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Text("Complete!",style: new TextStyle(fontFamily: "Montesserat", fontSize: 17.0, color: Colors.amber, fontWeight: FontWeight.bold)) ,
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
              secondaryBackground: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_forever, color: Colors.amber, size: 20.0,),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Text("Delete!",style: new TextStyle(fontFamily: "Montesserat", fontSize: 17.0, color: Colors.amber, fontWeight: FontWeight.bold)) ,
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

                    TodoModel todoModel = listOfTodos[position];
                    listOfTodos.removeAt(position);

                    databaseRepo.deleteTodo(todoModel);

                  });


                }else if(dismissDirection == DismissDirection.startToEnd){
                  setState(() {
                    print(position);
                    TodoModel todoModel = listOfTodos[position];
                    listOfTodos.removeAt(position);

                    todoModel.status = Constants.COMPLETED;
                    databaseRepo.updateTodo(todoModel);


                  });

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

