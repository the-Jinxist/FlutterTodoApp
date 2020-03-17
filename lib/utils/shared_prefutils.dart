import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider/user.dart';

class SharedPrefsUtils{

  Future<SharedPreferences> _getSharePrefsInstance() async{
    return await SharedPreferences.getInstance();
  }
  
  Future<User> getCurrentUser() async{
    var prefs = await _getSharePrefsInstance();
    var email = prefs.getString("email") != null ? prefs.getString("email") : "";
    var password = prefs.getString("password") != null ? prefs.getString("password") : "";

    return User(email: email, password: password);
  }
  
  Future<bool> saveUser(User user) async{
    var prefs = await _getSharePrefsInstance();
    await prefs.setString("email", user.email);
    return await prefs.setString("password", user.password);
  }

}