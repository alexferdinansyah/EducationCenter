import 'package:cloud_firestore/cloud_firestore.dart';

class Bootcamp {
  String? image;
  String? title;
  DateTime? date;
  String? time;
  String? place;
  String? speaker;
  String? link;
  String? description;
  String? category;
  List<ListBootcamp>? bootcampList; // Renamed from ListBootcamp to avoid conflicts

  Bootcamp({
    required this.image,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.place,
    required this.speaker,
    required this.link,
    required this.description,
    this.bootcampList, // Renamed property
  });

  factory Bootcamp.fromFirestore(Map<String, dynamic> data) {
    return Bootcamp(
      image: data['image'],
      title: data['title'],
      category: data['category'],
      date: data['date'].toDate(),// Ensured type consistency
      time: data['time'],
      place: data['place'],
      speaker: data['speaker'],
      link: data['link'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'category': category,
      'date': Timestamp.fromDate(date!), // Added check for null
      'time': time,
      'place': place,
      'speaker': speaker,
      'link': link,
      'description': description,
    };
  }

  // Method to check if the webinar has a valid link
  bool hasValidLink() {
    return link != null && link!.isNotEmpty;
  }

  // Method to update the webinar link
  void updateLink(String newLink) {
    link = newLink;
  }
}

class ListBootcamp {
  String? image;
  String? title;
  String? description;

  ListBootcamp({
    required this.image,
    required this.title,
    required this.description,
  });

  factory ListBootcamp.fromFirestore(Map<String, dynamic> data) {
    return ListBootcamp(
      image: data['image'],
      title: data['title'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
