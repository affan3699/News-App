import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "", email = "", address = "";

  @override
  void initState() {
    // TODO: implement initState
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(''),
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  title: Text(
                    '090078607',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  email,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  address,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void getProfileData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snapshot =
        await firestore.collection("users").doc(user!.uid).get();

    final data = snapshot.data() as dynamic;

    setState(() {
      email = data["Email"];
      name = data["Full Name"];
      address = data["Address"];
    });

    print(email);
  }
}
