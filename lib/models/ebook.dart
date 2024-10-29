import 'package:cloud_firestore/cloud_firestore.dart';

class EbookModel {
  String? image;
  String? title;
  String? description;
  String? ebookCategory;
  String? createdBy;
  DateTime? date;
  bool? isDraft;
  String? price;
  String? discount;
  List<EbookContent>? ebookContent;
  List<String>? completionBenefits;

  EbookModel({
    required this.image,
    required this.ebookCategory,
    required this.title,
    required this.description,
    this.createdBy,
    required this.isDraft,
    this.ebookContent,
    required this.date,
    required this.price,
    this.discount = "",
    required this.completionBenefits,
  });

  // Factory constructor to create an Ebook instance from Firestore data
  factory EbookModel.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? ebookContentData = data['ebook_content'];

    final List<EbookContent>? ebookContents = ebookContentData?.map((content) {
      return EbookContent.fromFirestore(content as Map<String, dynamic>);
    }).toList();

    return EbookModel(
      image: data['image'],
      ebookCategory: data['ebook_category'],
      title: data['title'],
      description: data['description'],
      createdBy: data['created_by'],
      date: (data['date'] as Timestamp).toDate(),
      isDraft: data['is_draft'],
      ebookContent: ebookContents,
      price: data['price'],
      discount: data['discount'],
      completionBenefits:
          (data['completion_benefits'] as List<dynamic>).cast<String>(),
    );
  }

  // Method to convert Ebook instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'ebook_category': ebookCategory,
      'title': title,
      'description': description,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'created_by': createdBy,
      'is_draft': isDraft,
      'ebook_content': ebookContent?.map((content) => content.toFirestore()).toList(),
      'completion_benefits': completionBenefits ?? [],
      'price': price,
      'discount': discount,
    };
  }
}

class EbookContent {
  int? ebookId;
  String? subTitle;
  String? image;
  String? subTitleDescription;
  List<String>? bulletList;
  String? textUnderList;
   String? price;

  EbookContent({
    required this.ebookId,
    required this.subTitle,
    this.image,
    required this.subTitleDescription,
    this.bulletList,
    this.textUnderList,
    required this.price,
  });

  // Factory constructor to create an EbookContent instance from Firestore data
  factory EbookContent.fromFirestore(Map<String, dynamic> data) {
    return EbookContent(
      ebookId: data['ebook_id'],
      subTitle: data['sub_title'],
      image: data['image'],
      subTitleDescription: data['sub_title_description'],
      bulletList: (data['bullet_list'] as List<dynamic>?)?.cast<String>(),
      textUnderList: data['text_under_list'],
      price: data['price'],
    );
  }

  // Method to convert EbookContent instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'ebook_id': ebookId,
      'sub_title': subTitle,
      'image': image,
      'sub_title_description': subTitleDescription,
      'bullet_list': bulletList,
      'text_under_list': textUnderList,
       'price': price,
    };
  }
}

class EbookCategories {
  String? name;
  DateTime? createdAt;

  EbookCategories({required this.name, required this.createdAt});

  // Factory constructor to create an EbookCategories instance from Firestore data
  factory EbookCategories.fromFirestore(Map<String, dynamic> data) {
    return EbookCategories(
      name: data['name'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  // Method to convert EbookCategories instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
