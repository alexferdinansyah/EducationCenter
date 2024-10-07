import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/components/videoLearnings.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/bootcamp.dart';
import 'package:project_tc/models/coupon.dart';
import 'package:project_tc/models/coupons.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/faq.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/models/webinar.dart';
import 'package:project_tc/screens/landing_page/EBook.dart';
import 'package:project_tc/services/extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class FirestoreService {
  final String uid;
  final String? courseId;
  final String? videoLearningId;
  FirestoreService({required this.uid, this.videoLearningId, this.courseId});
  FirestoreService.withoutUID()
      : uid = "",
        courseId = "",
        videoLearningId = "";

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
  final CollectionReference couponCollection =
      FirebaseFirestore.instance.collection('coupons');
  final CollectionReference faqCollection =
      FirebaseFirestore.instance.collection('faq');
  final CollectionReference BootcampCollection =
      FirebaseFirestore.instance.collection('bootcamp');
  final CollectionReference webinarCollection =
      FirebaseFirestore.instance.collection('webinar');
  final CollectionReference videoLearningCollection =
      FirebaseFirestore.instance.collection('videoLearning');

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
    final userDoc = await userCollection.doc(uid).get();

    if (userDoc.exists) {
      final userData = UserData.fromFirestore(userDoc);
      return userData;
    } else {
      throw Exception('User not found.');
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

  Stream<List<Map>> get allFaq {
    try {
      return courseCollection.snapshots().map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'faq': Faq.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming courses: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Future<List<String>> getAllCourseTitles() async {
    List<String> courseTitles = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('courses')
              .where('is_draft', isNotEqualTo: true)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var title = doc.data()['title'] as String?;
          if (title != null) {
            courseTitles.add(title);
          }
        }
      }
    } catch (e) {
      print('Error getting course data: $e');
    }

    return courseTitles;
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

  // Add a new Course document to Firestore
  Future<String> deleteCourse(String courseId) async {
    try {
      await courseCollection.doc(courseId).delete();
      return 'Success delete course';
    } catch (e) {
      print('Error delete course: $e');
      return 'Error delete course';

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

  Future addLearnCourse({
    required String courseId,
    required LearnCourse data,
  }) async {
    try {
      await courseCollection
          .doc(courseId)
          .collection('learn_course')
          .add(data.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future updateLearnCourse({
    required String courseId,
    required String learnCourseId,
    String? fieldName,
    String? data,
    required bool isUpdating,
  }) async {
    try {
      if (isUpdating) {
        await courseCollection
            .doc(courseId)
            .collection('learn_course')
            .doc(learnCourseId)
            .update({fieldName!: data});
      } else {
        await courseCollection
            .doc(courseId)
            .collection('learn_course')
            .doc(learnCourseId)
            .delete();
      }
    } catch (e) {
      print(e);
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

  Stream<List<Map<String, dynamic>>?> get allLearnCourse {
    try {
      final learnCourseCollection =
          courseCollection.doc(courseId).collection('learn_course');
      return learnCourseCollection
          .orderBy('created_at', descending: false)
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> learnCourses = [];
        final course = await courseCollection.doc(courseId).get();

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;

          try {
            learnCourses.add({
              'id': document.id,
              'learn_course': LearnCourse.fromFirebase(data),
            });
          } catch (error) {
            print('Error getting course data: $error');
          }
        }

        learnCourses.insert(0, {'course_name': course.get('title')});

        return learnCourses;
      });
    } catch (error) {
      print('Error streaming learn course: $error');
      return Stream.value([]); // Return an empty list in case of an error
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

  Stream<List<Map>> webinarAndBootcampStream() {
    final webinarStream = allWebinar;
    final bootcampStream = allBootcamp;

    return Rx.zip(
      [webinarStream, bootcampStream],
      (values) => values.first + values.last,
    );
  }

  Stream<List<Map>> videoLearningAndEBookStream() {
    final MyVideoLearningstream = allMyVideoLearnings;
    

    return Rx.zip(
      [MyVideoLearningstream],
      (values) => values.first! + values.last,
    );
  }

  Stream<List<Map<String, dynamic>>?> get allProduk {
    try {
      final produkCollection = userCollection.doc(uid).collection('Produk');
      return produkCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> produks = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          final String produkType = data['produkType']
              as String; // Menyimpan tipe event (webinar/bootcamp)
          final DocumentReference produkReference =
              data['produk'] as DocumentReference; // Referensi ke dokumen event
          final String status = data['status'] as String; // Status event

          try {
            if (produkType == 'videoLearning') {
              // Mendapatkan data webinar berdasarkan referensi dokumen
              final MyVideoLearning myVideoLearningdata = await getVideoLearningData(produkReference);
              produks.add({
                'id': produkReference.id, // ID dari dokumen webinar
                'produk': myVideoLearningdata, // Data webinar setelah diproses
                'status': status, // Status event
                'prodakType': 'videoLearning' // Menandai event sebagai webinar
              });
            } 
            // else if (produkType == 'ebook') {
            //   // Mendapatkan data bootcamp berdasarkan referensi dokumen
            //   final Ebook ebookData =
            //       await getEBookData(produkReference);
            //   events.add({
            //     'id': produkReference.id, // ID dari dokumen bootcamp
            //     'produk': ebookData, // Data bootcamp setelah diproses
            //     'status': status, // Status event
            //     'produk': 'ebook' // Menandai event sebagai bootcamp
            //   });
            // }
          } catch (error) {
            print('Error getting produk data: $error');
          }
        }

        return produks; // Mengembalikan daftar events (webinar dan bootcamp)
      });
    } catch (error) {
      print('Error streaming produk: $error');
      return Stream.value(
          []); // Kembalikan stream dengan list kosong jika terjadi error
    }
  }

  Stream<List<Map<String, dynamic>>?> get allEvent {
    try {
      final eventCollection = userCollection.doc(uid).collection('Event');
      return eventCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> events = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          final String eventType = data['eventType']
              as String; // Menyimpan tipe event (webinar/bootcamp)
          final DocumentReference eventReference =
              data['event'] as DocumentReference; // Referensi ke dokumen event
          final String status = data['status'] as String; // Status event

          try {
            if (eventType == 'webinar') {
              // Mendapatkan data webinar berdasarkan referensi dokumen
              final Webinar webinarData = await getWebinarData(eventReference);
              events.add({
                'id': eventReference.id, // ID dari dokumen webinar
                'event': webinarData, // Data webinar setelah diproses
                'status': status, // Status event
                'eventType': 'webinar' // Menandai event sebagai webinar
              });
            } else if (eventType == 'bootcamp') {
              // Mendapatkan data bootcamp berdasarkan referensi dokumen
              final Bootcamp bootcampData =
                  await getBootcampData(eventReference);
              events.add({
                'id': eventReference.id, // ID dari dokumen bootcamp
                'event': bootcampData, // Data bootcamp setelah diproses
                'status': status, // Status event
                'eventType': 'bootcamp' // Menandai event sebagai bootcamp
              });
            }
          } catch (error) {
            print('Error getting event data: $error');
          }
        }

        return events; // Mengembalikan daftar events (webinar dan bootcamp)
      });
    } catch (error) {
      print('Error streaming events: $error');
      return Stream.value(
          []); // Kembalikan stream dengan list kosong jika terjadi error
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

  // Add a new Article document to Firestore
  Future<String> addArticle(Article article) async {
    try {
      final result = await articleCollection.add(article.toFirestore());
      return result.id;
    } catch (e) {
      print('Error adding article: $e');
      return 'Error adding article';
      // Handle the error as needed
    }
  }

  // Add a new Course document to Firestore
  Future<String> deleteArticle(String articleId) async {
    try {
      await articleCollection.doc(articleId).delete();
      return 'Success delete article';
    } catch (e) {
      print('Error delete article: $e');
      return 'Error delete article';

      // Handle the error as needed
    }
  }

  Future updateArticleFewField({
    String? articleId,
    String? title,
    String? description,
    String? category,
    String? image,
    DateTime? date,
  }) async {
    try {
      await articleCollection.doc(articleId).update({
        'title': title,
        'description': description,
        'category': category,
        'image': image,
        'date': Timestamp.fromDate(date!)
      });
    } catch (e) {
      print('Error adding article: $e');
      // Handle the error as needed
    }
  }

  Future updateArticleEachField({
    required String articleId,
    required String fieldName,
    required dynamic data,
  }) async {
    try {
      if (data is List<ArticleContent>) {
        final List<Map<String, dynamic>> contentData =
            data.map((content) => content.toFirestore()).toList();
        await articleCollection.doc(articleId).update({fieldName: contentData});
      } else {
        await articleCollection.doc(articleId).update({fieldName: data});
      }
    } catch (e) {
      print('Error update article: $e');
      // Handle the error as needed
    }
  }

  Stream<List<Map>> courseArticleStream() {
    final courseStream = allCourses;
    final articleStream = allArticle;
    final webinarStream = allWebinar;
    final bootcampStream = allBootcamp;
    final videoLearningStream = allVideoLearning;

    return Rx.zip(
      [
        courseStream,
        articleStream,
        webinarStream,
        bootcampStream,
        videoLearningStream
      ],
      (values) => values.first + values.last,
    );
  }

  Stream<List<Map>> get allVideoLearning {
    try {
      return videoLearningCollection
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'videoLearning': VideoLearning.fromFirestore(
                document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (e) {
      print('error streaming video learning');
      return Stream.value([]);
    }
  }

  Future<List<String>> getAllVideoLearningTitles() async {
    List<String> videoLearningTitles = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('videoLearnings')
              .where('is_draft', isNotEqualTo: true)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var title = doc.data()['title'] as String?;
          if (title != null) {
            videoLearningTitles.add(title);
          }
        }
      }
    } catch (e) {
      print('Error getting video learning data: $e');
    }

    return videoLearningTitles;
  }

  Future getVideoLearningData(DocumentReference videolearning) async {
    final videoLearningDoc = await videolearning.get();
    if (videoLearningDoc.exists) {
      final videoLearningData = VideoLearning.fromFirestore(
          videoLearningDoc.data() as Map<String, dynamic>);
      return videoLearningData;
    } else {
      throw Exception('video learning not found');
    }
  }

  Future<String> addVideoLearning(VideoLearning videoLearning) async {
    try {
      final result =
          await videoLearningCollection.add(videoLearning.toFirestore());
      return result.id;
    } catch (e) {
      print('Error adding video learning: $e');
      return 'Error adding video learning';

      // Handle the error as needed
    }
  }

  Future<String> deleteVideoLearning(String videoLearningId) async {
    try {
      await videoLearningCollection.doc(videoLearningId).delete();
      return 'Success delete video learning';
    } catch (e) {
      print('Error delete video learning: $e');
      return 'Error delete video learning';

      // Handle the error as needed
    }
  }

  Future updateVideoLearningFewField({
    String? videoLearningId,
    String? title,
    String? price,
    String? description,
    String? image,
  }) async {
    try {
      await videoLearningCollection.doc(videoLearningId).update({
        'title': title,
        'price': price,
        'desription': description,
        'image': image
      });
    } catch (e) {
      print('Error adding video learning');
    }
  }

  Future updatelearningVideoDataEachField({
    required String videoLearningId,
    required String fieldName,
    required dynamic data,
  }) async {
    try {
      if (data is List<ChapterListVideo>) {
        final List<Map<String, dynamic>> chapterListVideoData = data
            .map((ChapterListVideo) => ChapterListVideo.toFirestore())
            .toList();
        await videoLearningCollection
            .doc(videoLearningId)
            .update({fieldName: chapterListVideoData});
      } else {
        await videoLearningCollection
            .doc(videoLearningId)
            .update({fieldName: data});
      }
    } catch (e) {
      print('Error adding video learning: $e');
    }
  }

  Future addLearningVideo({
    required String videoLearningId,
    required LearnVideo data,
  }) async {
    try {
      await videoLearningCollection
          .doc(videoLearningId)
          .collection('learn_videoLearning')
          .add(data.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future updateLearnVideo({
    required String videoLearningId,
    required String learnVideoId,
    String? fieldName,
    String? data,
    required bool isUpdating,
  }) async {
    try {
      if (isUpdating) {
        await videoLearningCollection
            .doc(videoLearningId)
            .collection('learn_videoLearning')
            .doc(learnVideoId)
            .update({fieldName!: data});
      } else {
        await videoLearningCollection
            .doc(videoLearningId)
            .collection('learn_videoLearning')
            .doc(learnVideoId)
            .delete();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMyVideoLearning(
      String videoLearningId, String userId, bool isPaid) async {
    final myVideoLearningCollection =
        userCollection.doc(userId).collection('my_videoLearning');
    final videoLearningReference = videoLearningCollection.doc(videoLearningId);

    final existingDocument = await myVideoLearningCollection
        .where('videoLearning', isEqualTo: videoLearningReference)
        .get();

    if (existingDocument.docs.isNotEmpty) {
      final documentId = existingDocument.docs.first.id;
      await myVideoLearningCollection.doc(documentId).update({
        'ispaid': isPaid,
      });
    } else {
      await myVideoLearningCollection.add({
        'videoLearning': videoLearningReference,
        'isPaid': isPaid,
        'status': 'not finished',
      });
    }
  }

  Stream<List<Map<String, dynamic>>?> get allLearnVideo {
    try {
      final learnVideoCollection = videoLearningCollection
          .doc(videoLearningId)
          .collection('learn_videoLearning');
      return learnVideoCollection
          .orderBy('created_at', descending: false)
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> learnVideos = [];
        final videoLearning =
            await videoLearningCollection.doc(videoLearningId).get();

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          try {
            learnVideos.add({
              'id': document.id,
              'learn_videoLearning': LearnVideo.fromFirebase(data),
            });
          } catch (error) {
            print('error getting video learning data: $error');
          }
        }
        learnVideos
            .insert(0, {'videoLearning_name': videoLearning.get('title')});
        //learnVideos.insert(0, {'id': videoLearning.get('id')});

        return learnVideos;
      });
    } catch (error) {
      print('error streaming learn course: $error');
      return Stream.value([]);
    }
  }

  Stream<List<Map<String, dynamic>>> get allMyVideoLearnings {
    try {
      final myVideosLearningCollection =
          userCollection.doc(uid).collection('my_videoLearning');
      return myVideosLearningCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> myVideosLearning = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;
          final videoLearningReference =
              data['videoLearning'] as DocumentReference;
          final isPaid = data['isPaid'] as bool;
          final status = data['status'] as String;

          try {
            final VideoLearning videoLearningData =
                await getVideoLearningData(videoLearningReference);
            myVideosLearning.add({
              'id': videoLearningReference.id,
              'videoLearning': videoLearningData,
              'isPaid': isPaid,
              'status': status
            });
          } catch (error) {
            print('Error getting video learning data: $error');
          }
        }

        return myVideosLearning;
      });
    } catch (error) {
      print('Error streaming my video learning: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Stream<List<Map>> get allFaqs {
    try {
      return faqCollection.snapshots().asyncMap((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'faq': Faq.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming faqs: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Stream<List<Map>> faqStream() {
    final faqStream = allFaq;

    return Rx.zip(
      [faqStream],
      (values) => values.first + values.last,
    );
  }

  //create transaction
  Future<String> createTransaction(TransactionModel transactionData) async {
    final DocumentReference docRef =
        await transactionCollection.add(transactionData.toFirestore());
    return docRef.id;
  }

  //create faq
  Future<String> createFAQ(Faq faq) async {
    try {
      final DocumentReference docRef =
          await faqCollection.add(faq.toFirestore());
      return docRef.id;
    } catch (e) {
      print("Error: $e");
      return "Failed to create FAQ: $e";
    }
  }

  Stream<List<Map>> get allBootcamp {
    try {
      return BootcampCollection.snapshots().map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'bootcamp':
                Bootcamp.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming bootcamp: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Future getBootcampData(DocumentReference bootcamp) async {
    final bootcampDoc = await bootcamp.get();

    if (bootcampDoc.exists) {
      final bootcampData =
          Bootcamp.fromFirestore(bootcampDoc.data() as Map<String, dynamic>);
      return bootcampData;
    } else {
      throw Exception('Bootcamp not found.');
    }
  }

  //create bootcamp
  Future<String> CreateBootcamp(Bootcamp bootcamp) async {
    try {
      final result = await BootcampCollection.add(bootcamp.toFirestore());
      return result.id;
    } catch (e) {
      print("Failed to create bootcamp: $e");
      return "Failed to create bootcamp";
    }
  }

  Future<String> deleteBootcamp(String bootcampId) async {
    try {
      await BootcampCollection.doc(bootcampId).delete();
      return 'Success delete bootcamp';
    } catch (e) {
      print('Error delete bootcamp: $e');
      return 'Error delete bootcamp';
    }
  }

  Stream<List<Map>> get allWebinar {
    try {
      return webinarCollection.snapshots().map((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((DocumentSnapshot document) {
          return {
            'id': document.id,
            'webinar':
                Webinar.fromFirestore(document.data() as Map<String, dynamic>)
          };
        }).toList();
      });
    } catch (error) {
      print('Error streaming webinar: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  Future getWebinarData(DocumentReference webinar) async {
    final webinarDoc = await webinar.get();

    if (webinarDoc.exists) {
      final webinarData =
          Webinar.fromFirestore(webinarDoc.data() as Map<String, dynamic>);
      return webinarData;
    } else {
      throw Exception('Webinar not found.');
    }
  }

  //create webinar
  Future<String> CreateWebinar(Webinar webinar) async {
    try {
      final result = await webinarCollection.add(webinar.toFirestore());
      return result.id;
    } catch (e) {
      print("Failed to create webinar: $e");
      return "Failed to create webinar";
    }
  }

  Future<String> deleteWebinar(String webinarId) async {
    try {
      await webinarCollection.doc(webinarId).delete();
      return 'Success delete webinar';
    } catch (e) {
      print('Error delete webinar: $e');
      return 'Error delete webinar';

      // Handle the error as needed
    }
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
          .orderBy('date', descending: true)
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
          await addMyVideoLearning(transaction.item!.id!, user.uid, true);
          await transactionCollection
              .doc(transactionId)
              .update({'status': 'Success'});
        } catch (e) {
          print('Error updating user my course data an my video learning $e');
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

  Stream<List<Map>> get couponsData {
    try {
      return couponCollection
          .snapshots()
          .asyncMap((QuerySnapshot querySnapshot) async {
        List<Map<String, dynamic>> coupons = [];

        for (final DocumentSnapshot document in querySnapshot.docs) {
          final data = document.data() as Map<String, dynamic>;

          // print(Coupon.fromFirestore(data));

          try {
            coupons.add({
              'id': document.id,
              'coupon': Coupon.fromFirestore(data),
            });
          } catch (error) {
            print('Error getting coupon data: $error');
          }
        }

        return coupons;
      });
    } catch (error) {
      print('Error streaming coupon: $error');
      return Stream.value([]); // Return an empty list in case of an error
    }
  }

  // Add a new Coupon document to Firestore
  Future<String> addCoupon(Coupon coupon) async {
    try {
      await couponCollection.add(coupon.toFirestore());
      return 'Success adding coupon';
    } catch (e) {
      print('Error adding coupon: $e');
      return 'Failed adding coupon';
      // Handle the error as needed
    }
  }

  // update coupon document to Firestore
  Future<String> updateCoupon(String couponId, Coupon coupon) async {
    try {
      await couponCollection.doc(couponId).set(coupon.toFirestore());
      return 'Success editing coupon';
    } catch (e) {
      print('Error editing coupon: $e');
      return 'Failed editing coupon';
      // Handle the error as needed
    }
  }

  // delete coupon document to Firestore
  Future<String> deleteCoupon(String couponId) async {
    try {
      await couponCollection.doc(couponId).delete();
      return 'Success deleting coupon';
    } catch (e) {
      print('Error deleting coupon: $e');
      return 'Failed deleting coupon';
      // Handle the error as needed
    }
  }

  // delete coupon document to Firestore
  Future<String> deleteFaq(String couponId) async {
    try {
      await faqCollection.doc(couponId).delete();
      return 'Success deleting faq';
    } catch (e) {
      print('Error deleting faq: $e');
      return 'Failed deleting faq';
      // Handle the error as needed
    }
  }

  Future getCoupon(DocumentReference coupon) async {
    // Get Reference Coupon Data
    final couponDoc = await coupon.get();

    if (couponDoc.exists) {
      final couponData =
          Coupon.fromFirestore(couponDoc.data() as Map<String, dynamic>);
      return couponData;
    } else {
      throw Exception('Coupon not found.');
    }
  }

  Future getCouponById(String couponId) async {
    final couponDoc = await couponCollection.doc(couponId).get();

    if (couponDoc.exists) {
      final coupon =
          Coupon.fromFirestore(couponDoc.data() as Map<String, dynamic>);
      return coupon;
    } else {
      throw Exception('Coupon not found.');
    }
  }

  Future getUserCoupon(DocumentReference coupon) async {
    // Get Reference Coupon Data
    final couponDoc = await coupon.get();

    if (couponDoc.exists) {
      final couponData =
          UserCoupon.fromFirestore(couponDoc.data() as Map<String, dynamic>);
      return couponData;
    } else {
      return null;
    }
  }

  Future checkUserCouponStatus(String code) async {
    try {
      QuerySnapshot query = await userCollection
          .doc(uid)
          .collection('user_coupon')
          .where('code', isEqualTo: code)
          .get();

      if (query.docs.first.exists) {
        UserCoupon couponData = await getUserCoupon(query.docs.first.reference);

        return {'coupon': couponData, 'id': query.docs.first.id};
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future checkValidationCoupon(
      String code, bool isProductCoupon, String? title) async {
    try {
      QuerySnapshot query =
          await couponCollection.where('code', isEqualTo: code).get();

      Map? userCouponData = await checkUserCouponStatus(code);
      if (query.docs.first.exists) {
        Coupon? couponData = await getCoupon(query.docs.first.reference);
        String? couponId = query.docs.first.id;

        final usageLimit = couponData!.usageLimit!;
        final usageRestriction = couponData.usageRestriction!;

        final statusCoupon = couponData.getStatus();

        if (statusCoupon == StatusCoupon.Expired) {
          return 'Coupon is expired';
        }

        if (couponData.status == Status.Draft ||
            couponData.visibility == VisibilityType.Private) {
          return 'Invalid code, please enter the right code';
        }

        if (usageLimit.perCoupon != null &&
            couponData.timesUsed! >= usageLimit.perCoupon!) {
          return 'Coupon usage limit exceeded';
        }

        if (usageLimit.perUser != null &&
            userCouponData != null &&
            userCouponData['coupon'].redeemTotal! >= usageLimit.perUser!) {
          return 'You have been redeeming this code';
        }

        if (!isProductCoupon && couponData.type == Coupons.productCoupon) {
          return 'You cannot use this coupon on payment, please use redeem code';
        }

        if (isProductCoupon && couponData.type != Coupons.productCoupon) {
          return 'You cannot redeem this code, please enter the right code';
        }

        if (isProductCoupon && couponData.type == Coupons.productCoupon) {
          await addCouponUsage(
            code,
            couponId,
            couponData.timesUsed!,
          );
          await redeemCode(couponData.product!);
          return 'Success Redeem';
        }

        if (usageRestriction.products!.isNotEmpty &&
            usageRestriction.excludeProducts!.isNotEmpty) {
          if (!usageRestriction.products!.contains(title) &&
              usageRestriction.excludeProducts!.contains(title)) {
            return 'You cannot use this code on this payment';
          }
        } else if (usageRestriction.products!.isNotEmpty &&
            usageRestriction.excludeProducts!.isEmpty) {
          if (!usageRestriction.products!.contains(title)) {
            return 'You cannot use this code in $title payment';
          }
        } else if (usageRestriction.products!.isEmpty &&
            usageRestriction.excludeProducts!.isNotEmpty) {
          if (usageRestriction.excludeProducts!.contains(title)) {
            return 'You cannot use this code in $title payment';
          }
        }

        return {'coupon': couponData, 'id': couponId};
      } else {
        return 'Coupon not exist';
      }
    } catch (e) {
      return 'Coupon invalid, please try another';
    }
  }

  Future addCouponUsage(
    String code,
    String couponId,
    int timesUsed,
  ) async {
    try {
      Map? userCouponData = await checkUserCouponStatus(code);
      if (userCouponData != null) {
        await userCollection
            .doc(uid)
            .collection('user_coupon')
            .doc(userCouponData['id'])
            .update(
                {'redeem_total': userCouponData['coupon'].redeemTotal! + 1});
      } else {
        final data = UserCoupon(code: code, redeemTotal: 1);
        await userCollection
            .doc(uid)
            .collection('user_coupon')
            .add(data.toFirestore());
      }
      await couponCollection
          .doc(couponId)
          .update({'times_used': timesUsed + 1});
    } catch (e) {
      print(e);
    }
  }

  Future redeemCode(String product) async {
    try {
      if (product == 'Membership') {
        final upgradeMembership =
            MembershipModel(memberType: 'Pro', joinSince: DateTime.now());
        try {
          await userCollection
              .doc(uid)
              .update({'membership': upgradeMembership.toFirestore()});
        } catch (e) {
          print('Error updating user membership data $e');
        }
      } else {
        try {
          final courseProduct =
              await courseCollection.where('title', isEqualTo: product).get();
          await addMyCourse(courseProduct.docs.first.id, uid, true);
          final videoProduct =
              await courseCollection.where('title', isEqualTo: product).get();
          await addMyVideoLearning(videoProduct.docs.first.id, uid, true);
        } catch (e) {
          print('Error updating user my course data and my video learning $e');
        }
      }
    } catch (e) {
      print(e);
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

  void updateWebinarEachField(
      {required String weId,
      required String fieldName,
      required String data}) {}
}
