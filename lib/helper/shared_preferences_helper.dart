import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static String sharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencesUsernameKey = "USERNAMEKEY";
  static String sharedPreferencesUserEmailKey = "USEREMAILKEY";

  //Saving data to Shared Preferences
  static Future <void> saveLoggedIn(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
      sharedPreferencesUserLoggedInKey,
      isUserLoggedIn,
    );
  }

  static Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      sharedPreferencesUsernameKey,
      username,
    );
  }

  static Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      sharedPreferencesUserEmailKey,
      email,
    );
  }

  //Getting data from Shared Preferences
  static Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
      sharedPreferencesUserLoggedInKey,
    );
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      sharedPreferencesUsernameKey,
    );
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      sharedPreferencesUserEmailKey,
    );
  }
}


