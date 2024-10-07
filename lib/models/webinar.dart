import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/components/webinars.dart';

class Webinar {
  String? image;
  String? title;
  DateTime? date;
  String? time;
  String? place;
  String? speaker;
  String? link;
  String? description;
  String? category;
  List<ListWebinar>? listWebinar;

  Webinar({
    required this.image,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.place,
    required this.speaker,
    required this.link,
    required this.description,
    this.listWebinar,
  });

  factory Webinar.fromFirestore(Map<String, dynamic> data) {
    // final List<dynamic>? webinar = data['list_webinar'];
    

    // final List<ListWebinar>? webinarLists = webinar?.map((webinarData) {
    //   return ListWebinar.fromFirestore(webinarData as Map<String, dynamic>);
    // }).toList();

    return Webinar(
      image: data['image'],
      title: data['title'],
      category: data['category'],
      date: data['date'].toDate(),
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
      'date': Timestamp.fromDate(date!),
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

class ListWebinar {
  String? image;
  String? title;
  String? description;

  ListWebinar({
    required this.image,
    required this.title,
    required this.description,
  });

  // Convert Firestore data to ListWebinar object
  factory ListWebinar.fromFirestore(Map<String, dynamic> data) {
    return ListWebinar(
      image: data['image'],
      title: data['title'],
      description: data['description'],
    );
  }

  // Convert ListWebinar object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
