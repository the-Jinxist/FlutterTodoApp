import 'package:flutter/material.dart';
import 'package:todo_app/database/Constants.dart';
import 'package:todo_app/database/todo_model.dart';
import 'package:todo_app/database/database_repo.dart';

class ViewTodoPage extends StatefulWidget {
  @override
  _ViewTodoPageState createState() => _ViewTodoPageState();

  final TodoModel model;

  ViewTodoPage({this.model});

}

class _ViewTodoPageState extends State<ViewTodoPage> {

  final formKey = new GlobalKey<FormState>();
  DatabaseRepo databaseRepo;

  @override
  void initState() {
    super.initState();

    databaseRepo = new DatabaseRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[

          GestureDetector(
              onTap: (){

                showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
                  titlePadding: EdgeInsets.only(left: 22.0, right: 20.0, top: 20.0),
                  title: Text("Delete Todo?"),
                  titleTextStyle: new TextStyle(
                    fontFamily: "Montesserat", fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  content: Text("Are you sure you wanna delete this todo? Are you really really sure?"),
                  contentTextStyle: new TextStyle(
                    fontFamily: "Montesserat", fontSize: 15.0, color: Colors.black,
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: (){

                      deleteTodo(widget.model);
                      Navigator.of(context).pop();

                    }, child: Text("Yea", style: new TextStyle(
                      fontFamily: "Montesserat", fontSize: 15.0, color: Colors.white,
                    ),), color: Colors.amber,),
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Nah", style: new TextStyle(
                      fontFamily: "Montesserat", fontSize: 15.0, color: Colors.black,
                    ),), color: Colors.white,)
                  ],
                ));

              },
              child: Icon(Icons.delete_forever, color: Colors.black, size: 25.0,)),
          SizedBox(width: 7.0,),
          GestureDetector(
              onTap: (){

                showDialog(context: context, barrierDismissible: false, builder: (context) =>
                    AlertDialog(
                      titlePadding: EdgeInsets.only(left: 22.0, right: 20.0, top: 20.0),
                      title: Text("Completed Todo?"),
                      titleTextStyle: new TextStyle(
                        fontFamily: "Montesserat", fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 10.0,
                      content: Text("Are you sure you've completed this todo? Are you really really sure?"),
                      contentTextStyle: new TextStyle(
                        fontFamily: "Montesserat", fontSize: 15.0, color: Colors.grey,
                      ),
                      actions: <Widget>[
                        FlatButton(onPressed: (){

                          completeTodo(widget.model);
                          Navigator.of(context).pop();

                        }, child: Text("Yea", style: new TextStyle(
                          fontFamily: "Montesserat", fontSize: 15.0, color: Colors.white,
                        ),), color: Colors.amber,),
                        FlatButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Nah", style: new TextStyle(
                          fontFamily: "Montesserat", fontSize: 15.0, color: Colors.amber,
                        ),), color: Colors.white,)
                      ],
                    )
                );

              },
              child: Icon(Icons.check, color: Colors.amber, size: 25.0,)),
          SizedBox(width: 10.0,),
        ],
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.close, color: Colors.black, size: 25.0,)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(key: formKey,child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              TextFormField(
                initialValue: widget.model.todoTitle,
                onSaved: (value){
                  //todoTitle = value.trim();
                },
                maxLines: 1,
                autocorrect: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amber,
                          width: 3.0
                      )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  hintText: "Add Todo Title",
                  hintStyle:  new TextStyle(
                    fontFamily: "Montesserat", fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey,
                  ),
                ),

                autofocus: true,
                style: new TextStyle(
                    fontFamily: "Montesserat",
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Your Todo's description cannot be empty";
                  }else{
                    widget.model.todoTitle = value.trim();
                    return null;
                  }

                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: widget.model.todoDesc,
                onSaved: (value){
                  //todoDescription = value.trim();
                },
                validator: (value){
                  if(value.isEmpty){
                    return "Your Todo's description cannot be empty";
                  }else{
                    widget.model.todoDesc = value.trim();
                    return null;
                  }

                },
                maxLines: 5,

                autocorrect: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber,
                        width: 3.0
                    )
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  hintText: "Add Todo Description",
                  hintStyle:  new TextStyle(
                    fontFamily: "Montesserat", fontSize: 15.0, color: Colors.grey,
                  ),
                ),
                autofocus: true,
                style: new TextStyle(
                    fontFamily: "Montesserat",
                    fontSize: 15.0
                ),
              ),
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: (){
                  var state = formKey.currentState;
                  var validated = state.validate();

                  if (validated){
                    print("The values of the todo model are as follows: Title - ${widget.model.todoTitle}. Description - ${widget.model.todoDesc}."
                        " Status - ${widget.model.status}. ID and TimeStamp - ${widget.model.id}, ${widget.model.timeInMillis}");
                    updateTodo(widget.model);
                  }

                },
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:  Colors.amber,
                    borderRadius: BorderRadius.circular(7.0),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
                  ),
                  child: Center(
                    child: Text("Update Todo", style: new TextStyle(color: Colors.white, fontFamily: Constants.MONTESSARAT_FAMILY, fontSize: 17.0, fontWeight: FontWeight.bold),),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Future<void> updateTodo(TodoModel model) async{
    await databaseRepo.updateTodo(model);
    Navigator.pop(context);
  }

  Future<void> completeTodo(TodoModel model) async{
    model.status = Constants.COMPLETED;
    await databaseRepo.updateTodo(model);
    Navigator.pop(context);
  }

  Future<void> deleteTodo(TodoModel model) async{
    await databaseRepo.deleteTodo(model);
    Navigator.pop(context);
  }
}
