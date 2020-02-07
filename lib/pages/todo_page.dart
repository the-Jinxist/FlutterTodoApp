
import 'package:flutter/material.dart';
import 'completed_page.dart';
import 'ongoing_page.dart';
import 'add_todo_page.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  PageController pageController;
  Color ongoingColor;
  double ongoingSize = 24.0;
  double completedSize = 17.0;
  Color completedColor;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    ongoingColor = Colors.amber;
    completedColor = Colors.black;

    pageController.addListener((){
      if (pageController.page < 0.5 ){

        setState(() {
          ongoingColor = Colors.amber;
          ongoingSize = 24.0;
          completedColor = Colors.black;
          completedSize = 17.0;

        });

      }else if(pageController.page > 0.5){

        setState(() {
          completedColor = Colors.amber;
          completedSize = 24.0;
          ongoingColor = Colors.black;
          ongoingSize = 17.0;
        });
      }
    });
  }

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
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          ongoingColor = Colors.amber;
                          ongoingSize = 24.0;
                          completedColor = Colors.black;
                          completedSize = 17.0;

                        });

                        pageController.animateToPage(0, duration: Duration(microseconds: 10), curve: ElasticInCurve(0.8));
                      },
                      child: Text("Ongoing", style: new TextStyle(
                          color: ongoingColor,
                          fontSize: ongoingSize,

                      )  ),
                    ),
                    SizedBox(width: 10.0,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          completedColor = Colors.amber;
                          completedSize = 24.0;
                          ongoingColor = Colors.black;
                          ongoingSize = 17.0;


                        });

                        pageController.animateToPage(1, duration: Duration(microseconds: 10), curve: ElasticInCurve(0.8));

                      },
                      child: Text("Completed",  style: new TextStyle(
                        color: completedColor,
                        fontSize: completedSize,
                      ) ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0,),
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      OnGoingPage(),
                      CompletedPage()
                    ],
                    physics: ScrollPhysics(),
                    pageSnapping: true,
                    controller: pageController,
                  ),
                ),

              ],
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add, color: Colors.white, size: 25.0,),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTodoPage()));
          },
          elevation: 10.0, backgroundColor: Colors.amber
          ,),
      ),
    );
  }

}