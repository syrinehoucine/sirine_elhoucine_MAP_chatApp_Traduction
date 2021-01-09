import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isMessageSendByMe;
  MessageTile(
      this.message,
      this.isMessageSendByMe,
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(
          left: isMessageSendByMe ? 0.0 : 16.0,
          right: isMessageSendByMe ? 16.0 : 0.0,
        ),
        width: MediaQuery.of(context).size.width,
        alignment:
        isMessageSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: isMessageSendByMe
                    ? Radius.circular(12.0)
                    : Radius.circular(0.0),
                bottomRight: isMessageSendByMe
                    ? Radius.circular(0.0)
                    : Radius.circular(12.0)),
            color: isMessageSendByMe ? Colors.blue : Colors.grey[600],
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}