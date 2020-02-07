import 'package:flutter/material.dart';
import 'package:todo_app/database/database_repo.dart';
import 'package:todo_app/database/todo_model.dart';

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
    return Container(
      child: FutureBuilder<List<TodoModel>>(
        builder: (context, data){
          if(data.hasError){
            return Container(
              child: Center(child: Text("This error happened: ${data.error}", style: new TextStyle(fontFamily: "Montserrat"),),),
            );
          }else if(data.hasData){
            var listOfTodos = data.data;
            if (listOfTodos.isEmpty){
              return Container(
                child: Center(child: Text("You neva complete any todo yet...", style: new TextStyle(fontFamily: "Montserrat"),),),
              );
            }else{
              return Container(
                child: Center(child: Text("Yay! You've completed some..", style: new TextStyle(fontFamily: "Montserrat"),),),
              );
            }
          }

          return Center(child: CircularProgressIndicator(),);
        },
        future: databaseRepo.queryCompletedTodos(),
      ),
    );
  }
}
