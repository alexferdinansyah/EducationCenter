import 'package:cloud_firestore/cloud_firestore.dart';

class Bootcamp {
  String? name;
  String? price;
  String? image;
  String? description;

  Bootcamp({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Bootcamp.fromFirestore(Map<String, dynamic> data) {
    return Bootcamp(
      name: data['name'],
      price: data['price'],
      image: data['image'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'description': description,
    };
  }
}
