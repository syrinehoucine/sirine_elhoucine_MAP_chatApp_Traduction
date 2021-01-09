import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sirine_elhoucine/helper/shared_preferences_helper.dart';

import 'package:sirine_elhoucine/helper/constants.dart';
import 'package:sirine_elhoucine/services/database.dart';
import 'package:sirine_elhoucine/widgets/searchtilewidget.dart';
import 'package:sirine_elhoucine/views/chat_screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

String _myName;

class _SearchState extends State<Search> {
  Database db = new Database();
  TextEditingController searchController = new TextEditingController();
  QuerySnapshot searchSnapShot;

  initiateSearch() {
    db.getUserByUsername(searchController.text).then((val) {
      setState(() {
        searchSnapShot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            // ignore: deprecated_member_use
            itemCount: searchSnapShot.documents.length,
            itemBuilder: (context, index) {
              return SearchTile(
                // ignore: deprecated_member_use
                username: searchSnapShot.documents[index].data()["username"],
                // ignore: deprecated_member_use
                email: searchSnapShot.documents[index].data()["email"],
              );
            })
        : Container(
            child: Center(
              child: Text(
                "No matching user",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
  }

  getUserInfo() async {
    _myName = await SharedPreferencesHelper.getUsername();
    setState(() {});
    print("name: $_myName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search username',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}
