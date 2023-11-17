import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final CollectionReference meetRequestCollection =
      FirebaseFirestore.instance.collection('meet_request');

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
  Future<String> addCourse(Course course) async {
    try {
      final result = await courseCollection.add(course.toFirestore());
      return result.id;
    } catch (e) {
      print('Error adding course: $e');
      return 'Error adding course';

      // Handle the error as needed
    }
  }

  Future updateCourseFewField({
    String? courseId,
    String? title,
    String? learnLimit,
    String? price,
    String? courseCategory,
    String? courseType,
    bool? isBundle,
    bool? isBestSales,
  }) async {
    try {
      await courseCollection.doc(courseId).update({
        'title': title,
        'learn_limit': learnLimit,
        'price': price,
        'course_category': courseCategory,
        'course_type': courseType,
        'is_bundle': isBundle,
        'best_sales': isBestSales
      });
    } catch (e) {
      print('Error adding course: $e');
      // Handle the error as needed
    }
  }

  Future updateCourseEachField({
    required String courseId,
    required String fieldName,
    required dynamic data,
  }) async {
    try {
      if (data is List<ChapterList>) {
        final List<Map<String, dynamic>> chapterData =
            data.map((chapterList) => chapterList.toFirestore()).toList();
        await courseCollection.doc(courseId).update({fieldName: chapterData});
      } else {
        await courseCollection.doc(courseId).update({fieldName: data});
      }
    } catch (e) {
      print('Error adding course: $e');
      // Handle the error as needed
    }
  }

  // Add my courses sub collection
  Future<void> addMyCourse(String courseId, String userId, bool isPaid) async {
    final myCoursesCollection =
        userCollection.doc(userId).collection('my_courses');
    final courseReference = courseCollection.doc(courseId);

    // Check if a document with the provided course reference exists in the sub-collection
    final existingDocument = await myCoursesCollection
        .where('course', isEqualTo: courseReference)
        .get();

    if (existingDocument.docs.isNotEmpty) {
      // Document with the same course reference exists; update it
      final documentId = existingDocument.docs.first.id;
      await myCoursesCollection.doc(documentId).update({
        'isPaid': isPaid,
        // You can update other fields as needed
      });
    } else {
      // Document with the provided course reference does not exist; add it
      await myCoursesCollection.add({
        'course': courseReference,
        'isPaid': isPaid,
        'status': 'Not Finished',
      });
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
            myCourses.add({
              'id': courseReference.id,
              'course': courseData,
              'isPaid': isPaid,
              'status': status
            });
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

  Future<bool> checkTransaction(String? title) async {
    DocumentReference userDoc = userCollection.doc(uid);
    CollectionReference transactionCollection =
        userDoc.collection('transactions');

    // Query to get documents where the 'transaction' field is a reference to 'transactions'
    QuerySnapshot querySnapshot = await transactionCollection
        .where('transaction', isNotEqualTo: null)
        .get();

    // Check if any documents have the specified title within the 'transactions' collection
    for (final transactionDocument in querySnapshot.docs) {
      final data = transactionDocument.data() as Map<String, dynamic>;
      final transactionData = await data['transaction'].get();

      if (transactionData['item']['title'] == title &&
          transactionData['status'] != 'Failed') {
        return true; // Title exists within 'transactions' collection
      }
    }

    // Title does not exist within 'transactions' collection
    return false;
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
      } else {
        try {
          await addMyCourse(transaction.item!.id!, user.uid, true);
          await transactionCollection
              .doc(transactionId)
              .update({'status': 'Success'});
        } catch (e) {
          print('Error updating user my course data $e');
        }
      }
    } catch (e) {
      print('Error getting transaction data $e');
    }
  }

  Future cancelTransactionUser(transactionId, UserData user,
      TransactionModel transaction, String reason) async {
    try {
      await transactionCollection
          .doc(transactionId)
          .update({'status': 'Failed', 'reason': reason});
    } catch (e) {
      print('Error getting transaction data $e');
    }
  }

  // Add a new meet request document to Firestore
  Future addMeetRequest(MeetModel meet, String courseId, String uid) async {
    try {
      // Reference to the Firestore collection

      // Perform a query to count documents that match the criteria
      QuerySnapshot query = await meetRequestCollection
          .where('course_id', isEqualTo: courseId)
          .where('uid', isEqualTo: uid)
          .get();

      // Check if the count is less than five
      if (query.size < 5) {
        // If there are fewer than five matching documents, add a new one
        await meetRequestCollection.add(meet.toFirestore());
        return true;
      } else {
        return false;
        // Handle the case where you have reached the limit
      }
    } catch (e) {
      print('Error adding meet: $e');
      // Handle the error as needed
    }
  }

  Future openWhatsapp(DateTime date, String? note, String courseName) async {
    var countryCode = '+62';
    var number = '87742812548';
    String? message;
    if (note != '') {
      message = Uri.encodeComponent(
          "Saya ingin mengajukan zoom meeting tentang course $courseName\nWaktu & Tanggal: ${date.formatDateAndTime()}\nnote: $note");
    } else {
      message = Uri.encodeComponent(
          "Saya ingin mengajukan zoom meeting tentang course $courseName\nWaktu & Tanggal: ${date.formatDateAndTime()}");
    }
    var whatsappUrl =
        Uri.parse("https://wa.me/${countryCode + number}?text=$message");
    try {
      launchUrl(whatsappUrl);
    } catch (e) {
      print(e.toString());
    }
  }
}
