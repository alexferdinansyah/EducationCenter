import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/ebook.dart';

class LearnEbookController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<Map?> documentSnapshot = Rx<Map?>(null);

  void fetchDocument(String id, String? userId) async {
    try {
      CollectionReference usersCollection = _firestore.collection('users');
      CollectionReference ebookCollection = _firestore.collection('ebook');
      DocumentReference ebook = ebookCollection.doc(id);
      final getEbook = await ebook.get();
      final EbookModel ebookData =
          EbookModel.fromFirestore(getEbook.data()! as Map<String, dynamic>);
      final learnEbook = await ebook
          .collection('learn_ebook')
          .orderBy('created_at', descending: false)
          .get();
      // Reference to the user's document

      DocumentReference userDoc = usersCollection.doc(userId);
      // Reference to the my_ebook subcollection
      CollectionReference myEbookCollection = userDoc.collection('my_ebooks');

      QuerySnapshot querySnapshot = await myEbookCollection
          .where('ebook', isEqualTo: ebook)
          .get();
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
        'learn_ebook': learnEbook.docs.map((learn) {
          return EbookContent.fromFirestore(learn.data());
        }),
        'ebook_name': ebookData.title,
        'price': ebookData.price,
        'isPaid': isPaid,
        'user_membership': memberType,
        'no_whatsapp': noWhatsapp,
      };
      documentSnapshot.value = learnData;
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  Future<bool?> getIsPaid(String? userId, String ebookId) async {
    CollectionReference usersCollection = _firestore.collection('users');
    CollectionReference ebookCollection =
        _firestore.collection('ebook');
    // Reference to the user's document

    DocumentReference userDoc = usersCollection.doc(userId);
    DocumentReference ebookDoc =
        ebookCollection.doc(ebookId);
    // Reference to the my_videolearning subcollection
    CollectionReference myEbookCollection =
        userDoc.collection('my_ebooks');

    // Query to get the specific course document by ID
    QuerySnapshot querySnapshot = await myEbookCollection
        .where('ebook', isEqualTo: ebookDoc)
        .get();
    
    print("a ${querySnapshot.docs}");

    // Check if the document exists and return it
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('isPaid');
    } else {
      // Return null if the document is not found
      return null;
    }
  }
}
