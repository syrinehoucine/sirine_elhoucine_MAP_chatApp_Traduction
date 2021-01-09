import 'package:flutter/material.dart';

import 'package:sirine_elhoucine/services/auth.dart';
import 'package:sirine_elhoucine/helper/shared_preferences_helper.dart';
import 'package:sirine_elhoucine/widgets/textformfieldwidget.dart';
import 'package:sirine_elhoucine/widgets/custombuttonwidget.dart';
import 'package:sirine_elhoucine/views/chat_rooms.dart';
import 'package:sirine_elhoucine/services/database.dart';


class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  Auth auth = new Auth();
  Database db = new Database();
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfo = {
        "username": usernameController.text,
        "email": emailController.text
      };

      SharedPreferencesHelper.saveUsername(usernameController.text);
      SharedPreferencesHelper.saveEmail(emailController.text);

      setState(() {
        isLoading = true;
      });

      auth
          .signUpWithEmailAndPassword(
          emailController.text, passwordController.text)
          .then((value) {
        db.uploadUserInfo(userInfo);
        SharedPreferencesHelper.saveLoggedIn(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {


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
                    hintText: 'username',
                    textType: TextInputType.text,
                    controller: usernameController,
                    validator: (value) {
                      return value.isEmpty || value.length < 8
                          ? 'Field must be at least 8 characters'
                          : null;
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: 'email',
                    textType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (val) {
                      return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                          ? null
                          : "Provide valid email";
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: 'password',
                    obscureText: true,
                    controller: passwordController,
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
              height: 24.0,
            ),
            GestureDetector(
              onTap: () {
                signMeUp();
              },
              child: CustomButton(
                text: 'Sign Up',
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                widget.toggle();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Already have an account? Sign in now',
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
