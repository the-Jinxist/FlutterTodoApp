import 'package:flutter/material.dart';
import 'package:todo_app/database/Constants.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final formKey = new GlobalKey<FormState>();

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: true,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Scrollable(
            viewportBuilder: (context, viewport) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60.0,),
                Image.asset('assets/images/user.png', fit: BoxFit.fill, width: 60.0, height: 60.0, ),
                SizedBox(height: 7.0,),
                Text("Create An Account", style: new TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: Constants.MONTESSARAT_FAMILY, fontWeight: FontWeight.bold),),
                Text("Create an account to sync you todos across multiple devices", style: new TextStyle(color: Colors.black, fontSize: 15.0, fontFamily: Constants.MONTESSARAT_FAMILY),),
                SizedBox(height: 25.0,),
                Form( key: formKey, child: Column(
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
                      maxLines: 1,
                      autocorrect: true,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            )
                        ),

                        hintText: "Your email address",
                        hintStyle:  new TextStyle(
                          fontFamily: "Montesserat", fontSize: 15.0, color: Colors.grey,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      style: new TextStyle(
                          fontFamily: "Montesserat",
                          fontSize: 15.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "Please input a valid password";
                        }else{
                          email = value.trim();
                          return null;
                        }

                      },
                      maxLines: 1,
                      autocorrect: true,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            )
                        ),
                        hintText: "Your password",
                        hintStyle:  new TextStyle(
                          fontFamily: "Montesserat", fontSize: 15.0, color: Colors.grey,
                        ),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
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
                        state.validate();
                      },
                      child: Card(

                        elevation: 5.0,
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:  Colors.amber,
                          ),
                          child: Center(
                            child: Text("Log in", style: new TextStyle(color: Colors.white, fontFamily: Constants.MONTESSARAT_FAMILY, fontSize: 17.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    )
                  ],
                )
                )
              ],
            ),
          axisDirection: AxisDirection.down,
          ),
        ),
      ),
    );
  }
}
