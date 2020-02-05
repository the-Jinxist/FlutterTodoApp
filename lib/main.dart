import 'package:flutter/material.dart';
import 'utils/AppUtils.dart';

void main() => runApp(TodoPage());

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Montesserat",
          backgroundColor: Colors.black,
          primaryTextTheme: TextTheme(
            title: new TextStyle(
                fontSize: 24.0,
                fontFamily: "Montesserat",
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            display1: new TextStyle(
                fontSize: 17.0,
                fontFamily: "Montesserat",
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),
            subtitle: new TextStyle(
                fontSize: 15.0,
                fontFamily: "Montesserat",
                color: Colors.black,
                fontStyle: FontStyle.italic
            ),
          )
      ),
      home: Scaffold(
        body: Container(
          color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Your Todos", style: new TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold
                  ) ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10.0,),
                    Text("Ongoing", style: new TextStyle(
                        color: Colors.amber,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )  ),
                    SizedBox(width: 10.0,),
                    Text("Completed",  style: new TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                    ) ),
                  ],
                )

              ],
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add, color: Colors.white, size: 25.0,),
          onPressed: (){
          
        }, 
          elevation: 10.0, backgroundColor: Colors.amber
          ,),
      ),
    );
  }
}
