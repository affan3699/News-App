import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class NewsDetail extends StatefulWidget {
  String URL;

  NewsDetail(this.URL);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: WebView(
          initialUrl: widget.URL,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (value) {
            setState(() {
              showSpinner = true;
            });
          },
          onPageFinished: (value) {
            setState(() {
              showSpinner = false;
            });
          },
        ),
      ),
    );
  }
}
