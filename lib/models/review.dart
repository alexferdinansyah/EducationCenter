class Review {
  String? image;
  String? name;
  String? rating;
  String? description;

  Review({
    this.image,
    this.name,
    required this.rating,
    this.description,
  });
}
