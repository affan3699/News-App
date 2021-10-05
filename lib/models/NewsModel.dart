class NewsModel {
  String newsHead, newsDes, newsImg, newsUrl;

  NewsModel(
      {this.newsHead = "NEWS HEADLINE",
      this.newsDes = "SOME NEWS",
      this.newsImg = "SOME URL",
      this.newsUrl = "SOME URL"});

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
        newsHead: news["title"],
        newsDes: news["description"],
        newsImg: news["urlToImage"],
        newsUrl: news["url"]);
  }
}
