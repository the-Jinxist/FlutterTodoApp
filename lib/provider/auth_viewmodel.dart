import 'dart:math';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier{


  String _userName = "";

  String getName(){
    return _userName;
  }

  void setNewUserName(){
    _userName = _returnRandomName();
    print("The username now is: $_userName");
    notifyListeners();

  }

  String _returnRandomName(){
    var random = Random().nextInt(_randomListOfName.length - 1);
    return _randomListOfName[random];
  }

  var _randomListOfName = ["Larry", "Moto", "Melman", "Jack", "Keanu", "Bayo", "Grace", "Timon", "Maryanne", "Prosper", "Frank", "Neo", "Emmanuel"];

}