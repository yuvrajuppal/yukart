import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';

class sharepreferHelper {
  static String userIdkey = "USERKEY";
  static String userNamekey = "USERNAMEKEY";

  static String userEmailkey = "USEREMAILKEY";

  static String userImagekey = "USERIMAGEKEY";

  Future<bool> saveUserID(String getuserid)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getuserid);
  }

  Future<bool> saveUserName(String getusername)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getusername);
  }
Future<bool> saveUseremail(String getuseremail)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey, getuseremail);
  }
  Future<bool> saveUserImage(String getuserimage)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImagekey, getuserimage);
  }

  Future<String?> getUserid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }
  Future<String?> getUsername()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }
  Future<String?> getUseremail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }
  Future<String?> getUserImage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImagekey);
  }

}
