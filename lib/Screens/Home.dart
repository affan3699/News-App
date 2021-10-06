import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/Screens/Login.dart';
import 'package:http/http.dart';
import 'package:newsapp/models/NewsModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<NewsModel> newsList = <NewsModel>[];

  List<String> categories = [
    "Top Stories",
    "Headlines",
    "Popular News",
    "Sports News"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(color: Colors.black),
        ),
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
        child: SingleChildScrollView(
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
                    ),
                  ],
                ),
              ),
              Container(
                height: 45,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      splashColor: Colors.black38,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 21,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.speaker_notes_outlined,
                              size: 20,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 5),
                            Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: newsList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  //var trending = trendingList[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 300.0,
                      margin: EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 12.0),
                      child: NewsCard(context, index),
                    ),
                  );
                },
              ),
            ],
          ),
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

  Widget NewsCard(BuildContext context, int index) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xFFEAEAEA), width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    (newsList[index].newsImage == null)
                        ? "https://ak.picdn.net/shutterstock/videos/6137654/thumb/1.jpg"
                        : (newsList[index].newsImage),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            newsList[index].newsTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=ccee04ed2c9849c5869e896919422d80";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["articles"].forEach((element) {
        NewsModel newsModel = new NewsModel();
        newsModel = NewsModel.fromMap(element);
        newsList.add(newsModel);
        setState(() {
          //isLoading = false;
        });
      });
    });
  }
}
