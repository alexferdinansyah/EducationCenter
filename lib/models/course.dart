class Course {
  String? image;
  String? courseCategory;
  String? title;
  String? description;
  bool? isBundle;
  String? totalCourse;
  List<ListCourse>? listCourse;
  List<String>? completionBenefits; // MAKE THIS NOT OPTIONAL
  String? price;
  String? discount;
  String? courseType;
  String? status;

  Course({
    required this.image,
    required this.courseCategory,
    required this.title,
    required this.isBundle,
    this.totalCourse = "",
    this.description,
    this.listCourse,
    this.completionBenefits,
    required this.price,
    this.discount = "",
    this.courseType,
    this.status,
  });
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
}

class ChapterList {
  String? chapter;
  List<String>? subChapter;

  ChapterList({
    required this.chapter,
    List<String>? subChapter,
  }) : subChapter = subChapter ?? [];
}
