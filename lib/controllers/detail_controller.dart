import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/bootcamp.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/models/webinar.dart';

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

class DetailVideoLearningController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<VideoLearning?> documentSnapshot = Rx<VideoLearning?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('videoLearning').doc(id).get();
      documentSnapshot.value = VideoLearning.fromFirestore(snapshot.data()!);
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

class DetailEBookController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<EbookModel?> documentSnapshot = Rx<EbookModel?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('ebook').doc(id).get();
      documentSnapshot.value = EbookModel.fromFirestore(snapshot.data()!);
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}


class DetailBootcampController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Bootcamp?> documentSnapshot = Rx<Bootcamp?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('bootcamp').doc(id).get();
      documentSnapshot.value = Bootcamp.fromFirestore(snapshot.data()!);
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}

class DetailWebinarController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Webinar?> documentSnapshot = Rx<Webinar?>(null);

  void fetchDocument(String id) async {
    try {
      final snapshot = await _firestore.collection('webinar').doc(id).get();
      documentSnapshot.value = Webinar.fromFirestore(snapshot.data()!);
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
