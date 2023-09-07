class Article {
  String? image;
  String? category;
  String? title;
  String? description;
  String? date;
  List<ArticleContent>? articleContent;

  Article({
    required this.image,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    this.articleContent,
  });
}

class ArticleContent {
  String? subTitle;
  String? image;
  String? subTitleDescription;

  ArticleContent({
    required this.subTitle,
    this.image,
    required this.subTitleDescription,
  });
}
