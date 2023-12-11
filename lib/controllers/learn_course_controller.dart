import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/course.dart';

class LearnCourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Map?> documentSnapshot = Rx<Map?>(null);

  void fetchDocument(String id, String? userId) async {
    try {
      CollectionReference usersCollection = _firestore.collection('users');
      CollectionReference courseCollection = _firestore.collection('courses');
      DocumentReference course = courseCollection.doc(id);
      final getCourse = await course.get();
      final Course courseData =
          Course.fromFirestore(getCourse.data()! as Map<String, dynamic>);
      final learnCourse = await course
          .collection('learn_course')
          .orderBy('created_at', descending: false)
          .get();
      // Reference to the user's document

      DocumentReference userDoc = usersCollection.doc(userId);
      // Reference to the my_course subcollection
      CollectionReference myCourseCollection = userDoc.collection('my_courses');

      // Query to get the specific course document by ID
      QuerySnapshot querySnapshot =
          await myCourseCollection.where('course', isEqualTo: course).get();
      DocumentSnapshot getUser = await userDoc.get();

      bool? isPaid;
      Map? memberType;
      String? noWhatsapp;

      if (querySnapshot.docs.isNotEmpty) {
        isPaid = querySnapshot.docs.first.get('isPaid');
      } else {
        isPaid = null;
      }

      if (getUser.exists) {
        memberType = getUser.get('membership');
        noWhatsapp = getUser.get('noWhatsapp');
      } else {
        memberType = null;
      }

      Map learnData = {
        'limit_course': courseData.learnLimit,
        'learn_course': learnCourse.docs.map((learn) {
          return LearnCourse.fromFirebase(learn.data());
        }),
        'course_name': courseData.title,
        'price': courseData.price,
        'isPaid': isPaid,
        'user_membership': memberType,
        'no_whatsapp': noWhatsapp
      };
      documentSnapshot.value = learnData;
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  Future<bool?> getIsPaid(String? userId, String courseId) async {
    CollectionReference usersCollection = _firestore.collection('users');
    CollectionReference courseCollection = _firestore.collection('courses');
    // Reference to the user's document

    DocumentReference userDoc = usersCollection.doc(userId);
    DocumentReference courseDoc = courseCollection.doc(courseId);
    // Reference to the my_course subcollection
    CollectionReference myCourseCollection = userDoc.collection('my_courses');

    // Query to get the specific course document by ID
    QuerySnapshot querySnapshot =
        await myCourseCollection.where('course', isEqualTo: courseDoc).get();

    // Check if the document exists and return it
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('isPaid');
    } else {
      // Return null if the document is not found
      return null;
    }
  }
}
