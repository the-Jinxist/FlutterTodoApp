

class User{

  final String email, password;

  User({this.email, this.password});

  bool exists(){
    return email.isNotEmpty && password.isNotEmpty;
  }

}