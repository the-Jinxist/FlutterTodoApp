import 'package:flutter/material.dart';
import '../database/todo_model.dart';
import '../database/Constants.dart';
import '../database/database_repo.dart';
import 'todo_page.dart';
import 'package:intl/intl.dart';


class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  final formKey = new GlobalKey<FormState>();
  String todoTitle;
  String todoDescription;

  DatabaseRepo databaseRepo;

  @override
  void initState() {
    super.initState();

    databaseRepo = new DatabaseRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Todo", style: new TextStyle(
          fontFamily: "Montesserat", fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black
        ),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.done, color: Colors.amber, size: 20.0,),
          ),
        ],
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black, size: 20.0,),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,

            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  onSaved: (value){
                    todoTitle = value.trim();
                  },
                  maxLines: 1,
                  maxLength: 25,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    ),
                    hintText: "Add Todo Title",
                    hintStyle:  new TextStyle(
                        fontFamily: "Montesserat", fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey,
                    ),
                  ),
                  autofocus: true,
                  style: new TextStyle(
                    fontFamily: "Montesserat",
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "Your Todo's description cannot be empty";
                    }else{
                      todoTitle = value.trim();
                      return null;
                    }

                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  onSaved: (value){
                    todoDescription = value.trim();
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Your Todo's description cannot be empty";
                    }else{
                      todoDescription = value.trim();
                      return null;
                    }

                  },
                  maxLines: 3,
                  maxLength: 40,
                  autocorrect: true,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white
                        )
                    ),
                    hintText: "Add Todo Description",
                    hintStyle:  new TextStyle(
                        fontFamily: "Montesserat", fontSize: 19.0, color: Colors.grey,
                    ),
                  ),
                  autofocus: true,
                  style: new TextStyle(
                      fontFamily: "Montesserat",
                      fontSize: 19.0
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: (){
                    var state = formKey.currentState;
                    var validated = state.validate();

                    if(validated){

                      TodoModel todoModel = new TodoModel(status: Constants.ON_GOING, todoTitle: todoTitle,
                          todoDesc: todoDescription, timeInMillis: new DateTime.now().millisecondsSinceEpoch, id: new DateTime.now().millisecondsSinceEpoch);
                      print("The todoModel is: $todoModel");
                      if(todoModel.isComplete()){
                        addTodo(todoModel);
                      }

                    }
                  },
                  child: Card(
                    elevation: 10.0,
                    color: Colors.amber,
                    child: Container(
                      height: 50.0,
                      width: double.maxFinite,
                      child: Center(
                        child: Text("Add Todo", style: new TextStyle(
                            fontFamily: "Montesserat", fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17.0
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addTodo(TodoModel todoModel) async{
    await databaseRepo.insertTodo(todoModel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPageContainer()));
  }
}
