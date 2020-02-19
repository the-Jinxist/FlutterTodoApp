import 'package:flutter/material.dart';
import 'package:todo_app/database/Constants.dart';
import 'package:todo_app/database/todo_model.dart';

class ViewTodoPage extends StatefulWidget {
  @override
  _ViewTodoPageState createState() => _ViewTodoPageState();

  final TodoModel model;

  ViewTodoPage({this.model});

}

class _ViewTodoPageState extends State<ViewTodoPage> {
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

              },
              child: Icon(Icons.delete_forever, color: Colors.black, size: 25.0,)),
          SizedBox(width: 7.0,),
          GestureDetector(
              onTap: (){

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
        child: Form(child: Column(
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
                    //todoTitle = value.trim();
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
                    //todoDescription = value.trim();
                    return null;
                  }

                },
                maxLines: 5,
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
                 // var state = formKey.currentState;
                  //state.validate();
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
}
