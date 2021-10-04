import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/Screens/Login.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline_sharp,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text("Profile"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.lightBlueAccent,
                      ),
                      margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search News",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, "profile_screen");
        break;
      case 1:
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
        break;
    }
  }
}
