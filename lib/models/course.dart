class Course {
  String? image;
  String? typeCourse;
  String? title;
  bool? isBundle;
  String? totalCourse;
  String? price;
  String? discount;

  Course({
    required this.image,
    required this.typeCourse,
    required this.title,
    required this.isBundle,
    this.totalCourse = "",
    required this.price,
    this.discount = "",
  });
}
