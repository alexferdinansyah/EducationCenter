import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/user.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});
  FirestoreService.withoutUID() : uid = "";

  // collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

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
  ) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'noWhatsapp': noWhatsapp,
      'address': address,
      'education': education,
      'working': working,
      'reason': reason,
    });
  }

  // userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        photoUrl: snapshot['photoUrl'],
        role: snapshot['role'],
        noWhatsapp: snapshot['noWhatsapp'],
        address: snapshot['address'],
        education: snapshot['education'],
        working: snapshot['working'],
        reason: snapshot['reason']);
  }

  // get user docs stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
