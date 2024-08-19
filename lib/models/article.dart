import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String? image;
  String? category;
  String? title;
  String? description;
  String? createdBy;
  DateTime? date;
  bool? isDraft;
  List<ArticleContent>? articleContent;

  Article({
    required this.image,
    required this.category,
    required this.title,
    required this.description,
    this.createdBy,
    required this.date,
    required this.isDraft,
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
        createdBy: data['created_by'],
        date: data['date'].toDate(),
        isDraft: data['is_draft'],
        articleContent: articleContents);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'category': category,
      'title': title,
      'description': description,
      'created_by': createdBy,
      'date': Timestamp.fromDate(date!),
      'is_draft': isDraft,
      'article_content':
          articleContent?.map((content) => content.toFirestore()).toList()
    };
  }
}

class ArticleContent {
  int? articleId;
  String? subTitle;
  String? image;
  String? subTitleDescription;
  List<String>? bulletList;
  String? textUnderList;

  ArticleContent({
    required this.articleId,
    required this.subTitle,
    this.image,
    required this.subTitleDescription,
    this.bulletList,
    this.textUnderList,
  });

  // Convert Firestore data to ArticleContent object
  factory ArticleContent.fromFirestore(Map<String, dynamic> data) {
    return ArticleContent(
      articleId: data['article_id'],
      subTitle: data['sub_title'],
      image: data['image'],
      subTitleDescription: data['sub_title_description'],
      bulletList: (data['bullet_list'] as List<dynamic>).cast<String>(),
      textUnderList: data['text_under_list'],
    );
  }

  // Convert ArticleContent object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'article_id': articleId,
      'sub_title': subTitle,
      'image': image,
      'sub_title_description': subTitleDescription,
      'bullet_list': bulletList ?? [],
      'text_under_list': textUnderList,
    };
  }
}

class Categories {
  String? name;
  DateTime? createdAt;

  Categories({required this.name, required this.createdAt});

  // Convert Firestore data to ArticleContent object
  factory Categories.fromFirestore(Map<String, dynamic> data) {
    return Categories(
        name: data['name'], createdAt: data['created_at'].toDate());
  }

  // Convert ArticleContent object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {'name': name, 'created_at': Timestamp.fromDate(createdAt!)};
  }
}
