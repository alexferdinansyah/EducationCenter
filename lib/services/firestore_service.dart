import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/user.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});
  FirestoreService.withoutUID() : uid = "";

  // collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection('courses');
  final CollectionReference articleCollection =
      FirebaseFirestore.instance.collection('articles');

  Future<Map<String, dynamic>> checkUser() async {
    try {
      final DocumentSnapshot userSnapshot = await userCollection.doc(uid).get();
      final result = <String, dynamic>{
        'exists': false,
        'isAdmin': false,
      };

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final userRole =
            userData['role']; // Assuming the role field is named 'role'

        // Check if the user's role is 'admin'
        if (userRole == 'admin') {
          result['isAdmin'] = true;
        }

        result['exists'] = true;
      }

      return result;
    } catch (e) {
      print(e.toString());
      return {
        'exists': false,
        'isAdmin': false,
      };
    }
  }

  Future updateUserData(
    String name,
    String photoUrl,
    String role,
    String noWhatsapp,
    String address,
    String education,
    String working,
    String reason,
    Map membershipData,
  ) async {
    final userData = {
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'noWhatsapp': noWhatsapp,
      'address': address,
      'education': education,
      'working': working,
      'reason': reason,
      'membership': membershipData
    };
    // Update user data
    return userCollection.doc(uid).set(userData);
  }

  // userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData.fromFirestore(snapshot);
  }

  // get user docs stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Map>> get allCourses {
    try {
      return courseCollection.snapshots().map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'course':
                Course.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming courses: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  // Add a new Course document to Firestore
  Future addCourse(Course course) async {
    try {
      await courseCollection.add(course.toFirestore());
    } catch (e) {
      print('Error adding course: $e');
      // Handle the error as needed
    }
  }

  Stream<List<Map>> get allArticle {
    try {
      return articleCollection.snapshots().map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'article':
                Article.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming courses: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  // Add a new Course document to Firestore
  Future addArticle(Article article) async {
    try {
      await articleCollection.add(article.toFirestore());
    } catch (e) {
      print('Error adding course: $e');
      // Handle the error as needed
    }
  }

  Stream<List<Map>> getCombinedStream() {
    final courseStream = allCourses;
    final articleStream = allArticle;

    return Rx.zip(
      [courseStream, articleStream],
      (values) => values.first + values.last,
    );
  }
}
