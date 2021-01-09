import 'package:flutter/material.dart';
import 'package:sirine_elhoucine/views/chat_screen.dart';


class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  ChatRoomTile(
      this.username,
      this.chatRoomId,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chatRoomId: chatRoomId,
              ),
            ));
      },
      child: Container(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                child: Text(
                  "${username.substring(0, 1).toUpperCase()}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                username,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}