import 'package:flutter/material.dart';
import 'package:todo_app/database/database_repo.dart';
import 'package:todo_app/database/todo_model.dart';
import 'package:todo_app/views/todo_view.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

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
        child: FutureBuilder<List<TodoModel>>(
          builder: (context, data){
            if(data.hasError){
              return Container(
                child: Center(child: Text("This error happened: ${data.error}",textAlign: TextAlign.center, style: new TextStyle(fontFamily: "Montesserat"),),),
              );
            }else if(data.hasData){
              var listOfTodos = data.data;
              if (listOfTodos.isEmpty){
                return Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset("blank_canvas.svg", width: 70.0, height: 70.0,),
                      SizedBox(height: 20.0,),
                      Text("You neva complete any todo yet...",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 17.0 ),
                      ),
                    ],
                  )
                );
              }else{
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
                direction: DismissDirection.startToEnd,
                onDismissed: (dismissDirection){
                    setState(() {
                      listOfTodos.removeAt(position);
                    });
                    databaseRepo.deleteTodo(listOfTodos[position]);
                },
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
                    ),),
                  )
                );
              }
            }

            return Center(child: CircularProgressIndicator(),);
          },
          future: databaseRepo.queryCompletedTodos(),
        ),
      ),
    );
  }
}
