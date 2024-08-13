import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/user.dart';

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

class DetailMembershipUser extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<MembershipModel?> membershipData = Rx<MembershipModel?>(null);

  void fetchMembership(String uid) async {
    try {
      final snapshot = await _firestore.collection('users').doc(uid).get();
      // Check if the snapshot exists and contains data
      if (snapshot.exists) {
        // Access the data map and retrieve a specific field
        var userData = snapshot.data();
        var specificField =
            userData!['membership']; // Replace with your field name

        membershipData.value = MembershipModel.fromFirestore(specificField);
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}
