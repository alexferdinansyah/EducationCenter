import 'package:cloud_firestore/cloud_firestore.dart';

class EbookModel {
  String? image;
  String? title;
  String? description;
  String? createdBy;
  DateTime? date;
  bool? isDraft;
  String? price;
  String? ebookLimit;
  String? discount;
  List<EbookContent>? ebookContent;
  List<ListEbook>? listEbook;
  List<ChapterListEbook>? chapterList;
  List<String>? completionBenefits;

  EbookModel({
    required this.image,
    required this.title,
    required this.description,
    this.createdBy,
    required this.isDraft,
    this.ebookContent,
    this.listEbook,
    this.chapterList,
    required this.date,
    required this.price,
    required this.ebookLimit,
    this.discount = "",
    required this.completionBenefits,
  });

  // Factory constructor to create an Ebook instance from Firestore data
  factory EbookModel.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? ebookContentData = data['ebook_content'];
    final List<dynamic>? ebookListData = data['list_ebook'];
    final List<dynamic>? chapterListData = data['chapter_list'];

   final List<ListEbook>? ebookLists =ebookListData?.map((ebookData) {
      return ListEbook.fromFirestore(ebookData as Map<String, dynamic>);
    }).toList();

    final List<ChapterListEbook>? chapterLists = chapterListData?.map((chapterList) {
      return ChapterListEbook.fromFirestore(chapterList as Map<String, dynamic>);
    }).toList();

    final List<EbookContent>? ebookContents = ebookContentData?.map((content) {
      return EbookContent.fromFirestore(content as Map<String, dynamic>);
    }).toList();

    return EbookModel(
      image: data['image'],
      title: data['title'],
      description: data['description'],
      createdBy: data['created_by'],
      date: (data['date'] as Timestamp).toDate(),
      isDraft: data['is_draft'],
      ebookContent: ebookContents,
      listEbook: ebookLists,
      chapterList: chapterLists,
      ebookLimit: data['ebook_limit'],
      price: data['price'],
      discount: data['discount'],
      completionBenefits:
          (data['completion_benefits'] as List<dynamic>).cast<String>(),
    );
  }

  get chapterListEbook => null;

  // Method to convert Ebook instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'created_by': createdBy,
      'is_draft': isDraft,
      'ebook_content': ebookContent?.map((content) => content.toFirestore()).toList(),
      'completion_benefits': completionBenefits ?? [],
      'price': price,
      'ebook_limit': ebookLimit,
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
  

  EbookContent({
    required this.ebookId,
    required this.subTitle,
    this.image,
    required this.subTitleDescription,
    this.bulletList,
    this.textUnderList,
    
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
      
    };
  }
}


class ListEbook{
  String? image;
  String? title;
  String? description;
  String? price;

  ListEbook({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  factory ListEbook.fromFirestore(Map<String, dynamic> data) {
    return ListEbook(
      image: data['image'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
    );
  }

    Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}

class ChapterListEbook {
  String? chapter;
  List<String>? subChapter;

  ChapterListEbook({
    required this.chapter,
    List<String>? subChapter,
  }) : subChapter = subChapter ?? [];

  // Convert Firestore data to ChapterListEbook object
  factory ChapterListEbook.fromFirestore(Map<String, dynamic> data) {
    return ChapterListEbook(
      chapter: data['chapter'],
      subChapter: (data['sub_chapter'] as List<dynamic>)
          .cast<String>(), // Ensure it's a List of Strings
    );
  }

  // Convert ChapterList object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'chapter': chapter,
      'sub_chapter': subChapter ?? [],
    };
  }
}

