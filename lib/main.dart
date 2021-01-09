import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'package:sirine_elhoucine/views/sign_in.dart';
import 'package:sirine_elhoucine/views/sign_up.dart';
import 'package:sirine_elhoucine/views/chat_rooms.dart';
import 'package:sirine_elhoucine/helper/authenticate.dart';
import 'package:sirine_elhoucine/helper/shared_preferences_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await SharedPreferencesHelper.getUserLoggedIn().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isUserLoggedIn != null
          ? isUserLoggedIn ? ChatRoom() : SignIn()
          : SignIn(),
    );
  }
}
