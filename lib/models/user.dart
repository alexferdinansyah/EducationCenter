import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});
}

class UserData {
  final String uid;
  final String name;
  final String photoUrl;
  final String role;
  final String noWhatsapp;
  final String address;
  final String education;
  final String working;
  final String reason;
  final MembershipModel membership;

  UserData({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.role,
    required this.noWhatsapp,
    required this.address,
    required this.education,
    required this.working,
    required this.reason,
    required this.membership,
  });

  factory UserData.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final membershipData = data['membership'] as Map<String, dynamic>?;

    return UserData(
        uid: snapshot.id,
        name: data['name'],
        photoUrl: data['photoUrl'],
        role: data['role'],
        noWhatsapp: data['noWhatsapp'],
        address: data['address'],
        education: data['education'],
        working: data['working'],
        reason: data['reason'],
        membership: MembershipModel.fromFirestore(membershipData!));
  }
}

class MembershipModel {
  final String memberType;
  final DateTime joinSince;

  MembershipModel({required this.memberType, required this.joinSince});

  // Convert Firestore data to ListCourse object
  factory MembershipModel.fromFirestore(Map<String, dynamic> data) {
    return MembershipModel(
      memberType: data['type'],
      joinSince: data['join_since'].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': memberType,
      'join_since': Timestamp.fromDate(
          joinSince), // Assuming Firestore uses Timestamp for DateTime
    };
  }
}
