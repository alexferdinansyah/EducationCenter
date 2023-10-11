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

  factory Article.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? articleContentData = data['article_content'];

    final List<ArticleContent>? articleContents =
        articleContentData?.map((content) {
      return ArticleContent.fromFirestore(content as Map<String, dynamic>);
    }).toList();

    return Article(
        image: data['image'],
        category: data['category'],
        title: data['title'],
        description: data['description'],
        date: data['date'],
        articleContent: articleContents);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'category': category,
      'title': title,
      'description': description,
      'date': date,
      'article_content':
          articleContent?.map((content) => content.toFirestore()).toList()
    };
  }
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

  // Convert Firestore data to ArticleContent object
  factory ArticleContent.fromFirestore(Map<String, dynamic> data) {
    return ArticleContent(
      subTitle: data['sub_title'],
      image: data['image'],
      subTitleDescription: data['sub_title_description'],
    );
  }

  // Convert ArticleContent object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'sub_title': subTitle,
      'image': image,
      'sub_title_description': subTitleDescription,
    };
  }
}
