import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection('users')
        .where("username", isEqualTo: username)
        .get();
  }

  getUserByEmail(String email) async {
    return await Firestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatroomMap) {
    Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .setData(chatroomMap)
        .catchError(
          (e) {
        print(e.toString());
      },
    );
  }

  addChatMessage(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError(
          (e) {
        print(e.toString());
      },
    );
  }

  getChatMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String username) async {
    return await Firestore.instance
        .collection("chatroom")
        .where("users", arrayContains: username)
        .snapshots();
  }
}
