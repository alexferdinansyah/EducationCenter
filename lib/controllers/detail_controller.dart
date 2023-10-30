import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';

class DetailCourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Course?> documentSnapshot = Rx<Course?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('courses').doc(id).get();
      documentSnapshot.value = Course.fromFirestore(snapshot.data()!);
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  getIsPaid(String? uid, String id) {}
}

class DetailArticleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Article?> documentSnapshot = Rx<Article?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('articles').doc(id).get();
      documentSnapshot.value = Article.fromFirestore(snapshot.data()!);
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}
