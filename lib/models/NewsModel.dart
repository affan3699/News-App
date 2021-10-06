class NewsModel {
  String newsTitle, newsDes, newsImage, newsUrl;

  NewsModel(
      {this.newsTitle = "NEWS Title",
      this.newsDes = "News Desc",
      this.newsImage = "URL",
      this.newsUrl = "URL"});

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
        newsTitle: news["title"],
        newsDes: news["description"],
        newsImage: news["urlToImage"],
        newsUrl: news["url"]);
  }
}
