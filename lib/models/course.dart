import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String? image;
  String? courseCategory;
  String? title;
  String? description;
  bool? isBundle;
  bool? isBestSales;
  bool? isDraft;
  String? totalCourse;
  List<ListCourse>? listCourse;
  List<ChapterList>? chapterList;
  List<String>? completionBenefits;
  List<String>? tag;
  String? learnLimit;
  String? price;
  String? discount;
  String? courseType;
  DateTime? createdAt;

  Course({
    required this.image,
    required this.courseCategory,
    required this.title,
    required this.isBundle,
    this.isBestSales,
    this.isDraft,
    this.totalCourse = "",
    this.description,
    this.listCourse,
    this.chapterList,
    required this.completionBenefits,
    this.tag,
    required this.learnLimit,
    required this.price,
    this.discount = "",
    this.courseType,
    required this.createdAt,
  });

  // Convert Firestore data to Course object
  factory Course.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? courseListData = data['list_course'];
    final List<dynamic>? chapterListData = data['chapter_list'];

    final List<ListCourse>? courseLists = courseListData?.map((courseData) {
      return ListCourse.fromFirestore(courseData as Map<String, dynamic>);
    }).toList();

    final List<ChapterList>? chapterLists = chapterListData?.map((chapterList) {
      return ChapterList.fromFirestore(chapterList as Map<String, dynamic>);
    }).toList();

    return Course(
      image: data['image'],
      courseCategory: data['course_category'],
      title: data['title'],
      description: data['description'],
      isBundle: data['is_bundle'],
      isBestSales: data['best_sales'],
      isDraft: data['is_draft'],
      totalCourse: data['total_course'],
      listCourse: courseLists,
      chapterList: chapterLists,
      completionBenefits:
          (data['completion_benefits'] as List<dynamic>).cast<String>(),
      tag: (data['tag'] as List<dynamic>).cast<String>(),
      learnLimit: data['learn_limit'],
      price: data['price'],
      discount: data['discount'],
      courseType: data['course_type'],
      createdAt: data['created_at'].toDate(),
    );
  }

  // Convert Course object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'course_category': courseCategory,
      'title': title,
      'description': description,
      'is_bundle': isBundle,
      'best_sales': isBestSales ?? false,
      'is_draft': isDraft,
      'total_course': totalCourse,
      'list_course': listCourse?.map((course) => course.toFirestore()).toList(),
      'chapter_list':
          chapterList?.map((chapter) => chapter.toFirestore()).toList(),
      'completion_benefits': completionBenefits ?? [],
      'tag': tag ?? [],
      'learn_limit': learnLimit,
      'price': price,
      'discount': discount,
      'course_type': courseType,
      'created_at': Timestamp.fromDate(createdAt!),
    };
  }
}

class ListCourse {
  String? image;
  String? title;
  String? description;
  String? price;

  ListCourse({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  // Convert Firestore data to ListCourse object
  factory ListCourse.fromFirestore(Map<String, dynamic> data) {
    return ListCourse(
      image: data['image'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
    );
  }

  // Convert ListCourse object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}

class ChapterList {
  String? chapter;
  List<String>? subChapter;

  ChapterList({
    required this.chapter,
    List<String>? subChapter,
  }) : subChapter = subChapter ?? [];

  // Convert Firestore data to ChapterList object
  factory ChapterList.fromFirestore(Map<String, dynamic> data) {
    return ChapterList(
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

class LearnCourse {
  String? title;
  String? videoUrl;

  LearnCourse({
    required this.title,
    required this.videoUrl,
  });

  factory LearnCourse.fromFirebase(Map<String, dynamic> data) {
    return LearnCourse(title: data['title'], videoUrl: data['video_url']);
  }

  Map<String, dynamic> toFirestore() {
    return {'title': title, 'video_url': videoUrl};
  }
}

class MeetModel {
  String? noWhatsapp;
  String? uid;
  String? courseId;
  DateTime? dateAndTime;
  String? note;

  MeetModel(
      {required this.noWhatsapp,
      required this.uid,
      required this.courseId,
      required this.dateAndTime,
      this.note});

  factory MeetModel.fromFirebase(Map<String, dynamic> data) {
    return MeetModel(
        noWhatsapp: data['no_whatsapp'],
        uid: data['uid'],
        courseId: data['course_id'],
        dateAndTime: data['date_and_time'].toDate(),
        note: data['note']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'no_whatsapp': noWhatsapp,
      'uid': uid,
      'course_id': courseId,
      'date_and_time': Timestamp.fromDate(dateAndTime!),
      'note': note
    };
  }
}
