import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/models/NewsModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../NewsCard.dart';

class Search extends StatefulWidget {
  String searchText;

  Search(this.searchText);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<NewsModel> newsList = <NewsModel>[];
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getNews(widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          widget.searchText.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
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
                margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                child: NewsCard(context, index, newsList),
              ),
            );
          },
        ),
      ),
    );
  }

  void getNews(String searchText) async {
    setState(() {
      showSpinner = true;
    });

    String url =
        "https://newsapi.org/v2/everything?q=$searchText&apiKey=ccee04ed2c9849c5869e896919422d80";

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["articles"].forEach((element) {
        NewsModel newsModel = new NewsModel();
        newsModel = NewsModel.fromMap(element);
        newsList.add(newsModel);
        setState(() {
          showSpinner = false;
        });
      });
    });
  }
}
