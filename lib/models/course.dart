class Course {
  String? image;
  String? courseCategory;
  String? title;
  String? description;
  bool? isBundle;
  String? totalCourse;
  List<ListCourse>? listCourse;
  List<ChapterList>? chapterList;
  List<String>? completionBenefits;
  List<String>? tag;
  String? learnLimit;
  String? price;
  String? discount;
  String? courseType;

  Course({
    required this.image,
    required this.courseCategory,
    required this.title,
    required this.isBundle,
    this.totalCourse = "",
    this.description,
    this.listCourse,
    this.chapterList,
    required this.completionBenefits,
    this.tag,
    this.learnLimit,
    required this.price,
    this.discount = "",
    this.courseType,
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
