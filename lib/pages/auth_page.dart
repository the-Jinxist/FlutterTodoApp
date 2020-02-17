import 'package:flutter/material.dart';
import 'package:todo_app/database/Constants.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black, size: 20.0,),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50.0,),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(radius: 50.0, child: Image.asset('assets/images/user.png', fit: BoxFit.fill,),),
                ),
              ),
              Text("Create An Account", style: new TextStyle(color: Colors.black, fontSize: 24.0, fontFamily: Constants.MONTESSARAT_FAMILY, fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Text("Create an account to sync you todos across multiple deveices", style: new TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: Constants.MONTESSARAT_FAMILY),),
              SizedBox(height: 50.0,),
              Form( child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please input a valid email";
                        }else{
                           email = value.trim();
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
                                color: Colors.black,
                            )
                        ),

                        hintText: "Your email address",
                        hintStyle:  new TextStyle(
                          fontFamily: "Montesserat", fontSize: 19.0, color: Colors.grey,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      style: new TextStyle(
                          fontFamily: "Montesserat",
                          fontSize: 19.0
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please input a valid password";
                        }else{
                          email = value.trim();
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
                              color: Colors.black,
                            )
                        ),
                        hintText: "Your password",
                        hintStyle:  new TextStyle(
                          fontFamily: "Montesserat", fontSize: 19.0, color: Colors.grey,
                        ),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      style: new TextStyle(
                          fontFamily: "Montesserat",
                          fontSize: 19.0
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    GestureDetector(
                      child: Container(
                        height: 100.0,
                        width: double.infinity,
                        color: Colors.amber,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 10.0, blurRadius: 10.0)],
                          color: Colors.amber
                        ),
                        child: Center(
                          child: Text("Log in", style: new TextStyle(color: Colors.white, fontFamily: Constants.MONTESSARAT_FAMILY, fontSize: 17.0, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
