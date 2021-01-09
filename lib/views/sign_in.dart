import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sirine_elhoucine/services/database.dart';
import 'package:sirine_elhoucine/services/auth.dart';
import 'package:sirine_elhoucine/views/chat_rooms.dart';
import 'package:sirine_elhoucine/widgets/textformfieldwidget.dart';
import 'package:sirine_elhoucine/widgets/custombuttonwidget.dart';
import 'package:sirine_elhoucine/helper/shared_preferences_helper.dart';


class SignIn extends StatefulWidget {
  //final Function toggle;
  //SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  Auth auth = new Auth();
  Database db = new Database();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  QuerySnapshot snapshotUserInfo;

  signMeIn() {
    if (formKey.currentState.validate()) {
      SharedPreferencesHelper.saveEmail(emailController.text);
      db.getUserByEmail(emailController.text).then((value) {
        snapshotUserInfo = value;
        SharedPreferencesHelper.saveEmail(
            // ignore: deprecated_member_use
            snapshotUserInfo.documents[0].data()["username"]);
        // ignore: deprecated_member_use
        print("Username: ${snapshotUserInfo.documents[0].data()["username"]}");
      });
      setState(() {
        isLoading = true;
      });

      auth
          .signInWithEmailAndPassword(
          emailController.text, passwordController.text)
          .then((value) {
        //print("${value.userId}");
        if (value != null) {
          SharedPreferencesHelper.saveLoggedIn(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // Sign in screen
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log.png', fit: BoxFit.cover),
      ),
      body: isLoading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'email',
                    textType: TextInputType.emailAddress,
                    validator: (val) {
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                          ? null
                          : "Provide valid email";
                    },
                  ),
                  TextFormFieldWidget(
                    controller: passwordController,
                    hintText: 'password',
                    obscureText: true,
                    validator: (val) {
                      return val.length < 8
                          ? "Password must be at least 8 characters"
                          : null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                signMeIn();
              },
              child: CustomButton(
                text: 'Sign In',
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Don\'t have account? Register Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
