import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/models/NewsModel.dart';
import '../NewsCard.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'NewsDetail.dart';

class Caregories extends StatefulWidget {
  String category;

  Caregories(this.category);

  @override
  _CaregoriesState createState() => _CaregoriesState();
}

class _CaregoriesState extends State<Caregories> {
  List<NewsModel> newsList = <NewsModel>[];
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getNews(widget.category),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView.builder(
            itemCount: newsList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewsDetail(newsList[index].newsUrl)));
                },
                child: Container(
                  width: double.infinity,
                  height: 300.0,
                  margin:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                  child: NewsCard(context, index, newsList),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getNews(String category) async {
    setState(() {
      showSpinner = true;
    });

    String url = "";
    if (category == "Top Stories") {
      url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Headlines") {
      url =
          "https://newsapi.org/v2/top-headlines?language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Popular News") {
      url =
          "https://newsapi.org/v2/top-headlines?language=en&sortBy=popularity&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Sports News") {
      url =
          "https://newsapi.org/v2/top-headlines?category=sports&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Entertainment") {
      url =
          "https://newsapi.org/v2/top-headlines?category=entertainment&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Technology") {
      url =
          "https://newsapi.org/v2/top-headlines?category=technology&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Science") {
      url =
          "https://newsapi.org/v2/top-headlines?category=science&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Health") {
      url =
          "https://newsapi.org/v2/top-headlines?category=health&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    } else if (category == "Business") {
      url =
          "https://newsapi.org/v2/top-headlines?category=business&language=en&apiKey=ccee04ed2c9849c5869e896919422d80";
    }

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
