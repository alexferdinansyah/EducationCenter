import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/course.dart';

class LearnCourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Map?> documentSnapshot = Rx<Map?>(null);

  void fetchDocument(String id) async {
    try {
      final course = _firestore.collection('courses').doc(id);
      final getCourse = await course.get();
      final Course courseData = Course.fromFirestore(getCourse.data()!);
      final learnCourse = await course.collection('learn_course').get();
      Map learnData = {
        'limit_course': courseData.learnLimit,
        'learn_course': learnCourse.docs.map((learn) {
          return LearnCourse.fromFirebase(learn.data());
        }),
        'course_name': courseData.title
      };
      documentSnapshot.value = learnData;
    } catch (e) {
      print('Error fetching document: $e');
    }
  }
}
