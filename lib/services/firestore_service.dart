import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/user.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});
  FirestoreService.withoutUID() : uid = "";

  // collection reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String role) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'role': role,
    });
  }

  // userData from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot['name'], role: snapshot['role']);
  }

  // get user docs stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
