import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/learning.dart';

class LearnVideoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Map?> documentSnapshot = Rx<Map?>(null);


  void fetchDocument(String id, String? userId) async {
    try {
      CollectionReference usersCollection = _firestore.collection('users');
      CollectionReference videoLearningCollection = _firestore.collection('videoLearning');
      DocumentReference videoLearning = videoLearningCollection.doc(id);
      final getVideoLearning = await videoLearning.get();
      final VideoLearning videoLearningData = VideoLearning.fromFirestore(getVideoLearning.data()! as Map<String,dynamic>);
      final learnVideo = await videoLearning 
          .collection('learn_videoLearning')
          .orderBy('created_at', descending: false)
          .get();
      // Reference to the user's document

      DocumentReference userDoc = usersCollection.doc(userId);
      // Reference to the my_videolearning subcollection
      CollectionReference myVideoLearningCollection = userDoc.collection('my_videoLearning');

      QuerySnapshot querySnapshot = await myVideoLearningCollection.where('videoLearning', isEqualTo: videoLearning).get();
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
        'learn_videoLearning' : learnVideo.docs.map((learn) {
          return LearnVideo.fromFirebase(learn.data());
        }),
        'videoLearning_name' :videoLearningData.title,
        'price': videoLearningData.price,
        'isPaid': isPaid,
        'user_membership': memberType,
         'no_whatsapp': noWhatsapp,
      };
      documentSnapshot.value = learnData;
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  Future<bool?> getIsPaid(String? userId, String videoLearningId) async {
    CollectionReference usersCollection = _firestore.collection('users');
    CollectionReference videoLearningCollection = _firestore.collection('videoLearning');
    // Reference to the user's document

    DocumentReference userDoc = usersCollection.doc(userId);
    DocumentReference videoLearningDoc = videoLearningCollection.doc(videoLearningId);
    // Reference to the my_videolearning subcollection
    CollectionReference myVideoLearningCollection = userDoc.collection('my_videoLearning');

    // Query to get the specific course document by ID
    QuerySnapshot querySnapshot =
        await myVideoLearningCollection.where('videoLearning', isEqualTo: videoLearningDoc).get();

    // Check if the document exists and return it
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('isPaid');
    } else {
      // Return null if the document is not found
      return null;
    }
  }
}