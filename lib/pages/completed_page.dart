import 'package:flutter/material.dart';
import 'package:todo_app/database/Constants.dart';
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
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100,),
                        Image.asset('assets/images/note.png', width: 200.0, height: 200.0, scale: 1, colorBlendMode: BlendMode.darken, fit: BoxFit.fill, ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("You've not completed any todos yet...",
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 17.0 ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Swipe right to delete a todo.",
                            textAlign: TextAlign.center,
                            style: new TextStyle(fontFamily: "Montesserat", color: Colors.grey, fontSize: 13.0 ),
                          ),
                        ),
                      ],
                    ),
                  )
                );
              }else{
                return ListView.builder(
                  itemCount: listOfTodos.length,
                  itemBuilder: (context, position) =>
                    Dismissible(
                        key: UniqueKey(),
                        child: TodoView(todoModel: listOfTodos[position],),
                        onDismissed: (dismissDirection){
                          if(dismissDirection == DismissDirection.startToEnd){
                            setState(() {

                              TodoModel model = listOfTodos[position];

                              listOfTodos.removeAt(position);
                              databaseRepo.deleteTodo(model);
                            });
                          }else if(dismissDirection == DismissDirection.endToStart){
                            setState(() {

                              TodoModel model = listOfTodos[position];
                              model.status = Constants.ON_GOING;

                              listOfTodos.removeAt(position);
                              databaseRepo.updateTodo(model);
                            });
                          }


                        },
                      secondaryBackground: Container(
                        decoration: BoxDecoration( border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.work, color: Colors.amber, size: 20.0,),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10.0,),
                                  Text("Still Ongoing!",style: new TextStyle(fontFamily: "Montesserat", fontSize: 17.0, color: Colors.amber, fontWeight: FontWeight.bold)) ,
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
                              child: Text("Delete!",style: new TextStyle(fontFamily: "Montesserat", fontSize: 17.0, color: Colors.amber, fontWeight: FontWeight.bold)) ,
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
                  )
                );
              }
            }

            return Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,),);
          },
          future: databaseRepo.queryCompletedTodos(),
        ),
      ),
    );
  }
}
