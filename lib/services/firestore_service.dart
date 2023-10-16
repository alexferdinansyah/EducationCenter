import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/transaction.dart';
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
  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

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
        if (userRole == 'Admin') {
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

  Future updateUserPhoto(String photoUrl) {
    return userCollection.doc(uid).update({'photoUrl': photoUrl});
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

  Future getUserByUid(String uid) async {
    // Get Reference Courses Data
    final userDoc = await userCollection.doc(uid).get();

    if (userDoc.exists) {
      final userData = UserData.fromFirestore(userDoc);
      return userData;
    } else {
      throw Exception('Course not found.');
    }
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

  //get course data by reference
  Future getCourseData(DocumentReference course) async {
    // Get Reference Courses Data
    final courseDoc = await course.get();

    if (courseDoc.exists) {
      final courseData =
          Course.fromFirestore(courseDoc.data() as Map<String, dynamic>);
      return courseData;
    } else {
      throw Exception('Course not found.');
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

  // Add my courses sub collection
  Future addMyCourse(String courseId) async {
    try {
      final myCoursesCollection =
          userCollection.doc(uid).collection('my_courses');
      final courseReference = courseCollection.doc(courseId);

      // 1. Input Data into Subcollection
      await myCoursesCollection.add({
        'course': courseReference,
        'isPaid': true,
      });
    } catch (e) {
      print('Error adding course to my courses: $e');
    }
  }

  Stream<List<Map<String, dynamic>>?> get allMyCourses {
    try {
      final myCoursesCollection =
          userCollection.doc(uid).collection('my_courses');
      return myCoursesCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> myCourses = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          final courseReference = data['course'] as DocumentReference;
          final isPaid = data['isPaid'] as bool;
          final status = data['status'] as String;

          try {
            final Course courseData = await getCourseData(courseReference);
            myCourses.add(
                {'course': courseData, 'isPaid': isPaid, 'status': status});
          } catch (error) {
            print('Error getting course data: $error');
          }
        }

        return myCourses;
      });
    } catch (error) {
      print('Error streaming my courses: $error');
      return Stream.value([]); // Return an empty list in case of an error
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
      print('Error streaming articles: $error');
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

  Stream<List<Map>> courseArticleStream() {
    final courseStream = allCourses;
    final articleStream = allArticle;

    return Rx.zip(
      [courseStream, articleStream],
      (values) => values.first + values.last,
    );
  }

  //create transaction
  Future<String> createTransaction(TransactionModel transactionData) async {
    final DocumentReference docRef =
        await transactionCollection.add(transactionData.toFirestore());
    return docRef.id;
  }

  // create user transaction
  Future<void> updateUserTransaction(String transactionId) async {
    final CollectionReference transactionRef =
        userCollection.doc(uid).collection('transactions');
    final DocumentReference transactionDocRef =
        transactionCollection.doc(transactionId);

    // Add a reference to the transaction document in the user's "transactions" subcollection
    await transactionRef.add({'transaction': transactionDocRef});
  }

  //get transaction data by reference
  Future getTransactionData(DocumentReference transaction) async {
    // Get Reference Transaction Data
    final transactionDoc = await transaction.get();

    if (transactionDoc.exists) {
      final transactionData = TransactionModel.fromFirestore(
          transactionDoc.data() as Map<String, dynamic>);
      return transactionData;
    } else {
      throw Exception('transaction not found.');
    }
  }

  Stream<List<Map<String, dynamic>>?> get userTransaction {
    try {
      final myTransactionCollection =
          userCollection.doc(uid).collection('transactions');
      return myTransactionCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> myTransaction = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          final transactionReference = data['transaction'] as DocumentReference;

          try {
            final TransactionModel transactionData =
                await getTransactionData(transactionReference);
            myTransaction.add({
              'transaction': transactionData,
            });
          } catch (error) {
            print('Error getting transaction data: $error');
          }
        }

        return myTransaction;
      });
    } catch (error) {
      print('Error streaming my transaction: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Stream<List<Map>> get userRequestTransaction {
    try {
      return transactionCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> userTransaction = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;

          try {
            final UserData userData = await getUserByUid(data['uid']);
            userTransaction.add({
              'id': document.id,
              'user': userData,
              'transaction': TransactionModel.fromFirestore(data),
            });
          } catch (error) {
            print('Error getting transaction data: $error');
          }
        }

        return userTransaction;
      });
    } catch (error) {
      print('Error streaming user transaction: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Future confirmTransactionUser(
      transactionId, UserData user, TransactionModel transaction) async {
    try {
      if (transaction.item!.title == 'Membership') {
        final upgradeMembership =
            MembershipModel(memberType: 'Pro', joinSince: DateTime.now());
        try {
          await userCollection
              .doc(user.uid)
              .update({'membership': upgradeMembership.toFirestore()});
          await transactionCollection
              .doc(transactionId)
              .update({'status': 'Success'});
        } catch (e) {
          print('Error updating user membership data $e');
        }
      }
    } catch (e) {
      print('Error getting transaction data $e');
    }
  }
}
