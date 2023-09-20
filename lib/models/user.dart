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

  UserData(
      {required this.uid,
      required this.name,
      required this.photoUrl,
      required this.role,
      required this.noWhatsapp,
      required this.address,
      required this.education,
      required this.working,
      required this.reason});
}
