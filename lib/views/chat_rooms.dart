import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirine_elhoucine/helper/shared_preferences_helper.dart';
import 'package:sirine_elhoucine/views/sign_in.dart';
import 'package:sirine_elhoucine/widgets/chatRoomTile.dart';
import 'package:sirine_elhoucine/services/database.dart';
import 'package:sirine_elhoucine/views/search.dart';
import 'package:sirine_elhoucine/helper/authenticate.dart';
import 'package:sirine_elhoucine/helper/constants.dart';
import 'package:sirine_elhoucine/services/auth.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Auth auth = new Auth();
  Database db = new Database();
  Stream chatRoomsStream;
  SharedPreferencesHelper prefs = new SharedPreferencesHelper();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return ChatRoomTile(
                snapshot.data.documents[index].data["chatRoomId"]
                    .toString()
                    .replaceAll("_", "")
                    .replaceAll(Constants.myName.toString(), ""),
                snapshot.data.documents[index].data["chatRoomId"],
              );
            })
            : Center(
          child: Text(
            "Here will appear your conversations",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await SharedPreferencesHelper.getUsername();
    db.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/log.png', fit: BoxFit.cover),
        actions: [
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('sharedPreferencesUserLoggedInKey');
              prefs.remove('sharedPreferencesUsernameKey');
              prefs.remove('sharedPreferencesUserEmailKey');
              auth.signOut();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: chatRoomsList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search(),
            ),
          );
        },
      ),
    );
  }
}
