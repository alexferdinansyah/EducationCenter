class Course {
  String? image;
  String? typeCourse;
  String? title;
  String? description;
  bool? isBundle;
  String? totalCourse;
  List<ListCourse>? listCourse;
  List<String>? completionBenefits;
  String? price;
  String? discount;

  Course({
    required this.image,
    required this.typeCourse,
    required this.title,
    required this.isBundle,
    this.totalCourse = "",
    this.description,
    this.listCourse,
    this.completionBenefits,
    required this.price,
    this.discount = "",
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
