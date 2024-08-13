import 'package:cloud_firestore/cloud_firestore.dart';

class Faq {
  String? question;
  String? answer;

  Faq({
    required this.question,
    required this.answer,
  });

  factory Faq.fromFirestore(Map<String, dynamic> data) {
    return Faq(
      question: data['question'],
      answer: data['answer'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
