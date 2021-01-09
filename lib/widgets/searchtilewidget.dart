import 'package:flutter/material.dart';

import 'package:sirine_elhoucine/helper/constants.dart';
import 'package:sirine_elhoucine/views/chat_screen.dart';
import 'package:sirine_elhoucine/services/database.dart';



class SearchTile extends StatelessWidget {
  final String username;
  final String email;
  SearchTile({
    this.username,
    this.email,
  });

 // Create a chat Room, Send user to chat screen
  createChatRoomAndStartConversation({BuildContext context, String username}) {
    if (username != Constants.myName) {
      String chatRoomId = getChatRoomId(username, Constants.myName);
      Database db = new Database();

      List<String> users = [username, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId
      };
      db.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatRoomId: chatRoomId,
          ),
        ),
      );
    } else {
      print("You can't send a message to yourself");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(
                  context: context, username: username);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Send message",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Checks who is sending the message comparing the IDs of the chat rooms
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
