import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleAuthProvider _authProvider = GoogleAuthProvider();

  // create user object based on user
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            email: user.email!,
            verifiedEmail: user.emailVerified)
        : null;
  }

  // auth changes user stream
  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        // .map((User? user) => _userFromFirebaseUser(user)); same as below code
        .map(_userFromFirebaseUser);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'too-many-requests') {
        errorMessage =
            'This account has been temporarily disabled due to multiple failed login attempts. You can restore access immediately by resetting your password or try again later.';
      }
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      return errorMessage;
    } catch (e) {
      print('Non-Firebase Auth Error: ${e.toString()}');
      return 'An error occurred';
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
    String name,
    String noWhatsapp,
    String address,
    String education,
    String working,
    String email,
    String password,
    String reason,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with uid
      await FirestoreService(uid: user!.uid).updateUserData(
        name,
        'https://ui-avatars.com/api/?name=$name&color=7F9CF5&background=EBF4FF',
        'member',
        noWhatsapp,
        address,
        education,
        working,
        reason,
        {
          'type': 'Basic',
          'join_since': Timestamp.now(),
        },
      );

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      return errorMessage;
    } catch (e) {
      print('Non-Firebase Auth Error: ${e.toString()}');
      return 'An error occurred';
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      // final UserCredential userCredential =
      //     await _auth.signInWithPopup(_authProvider);
      // User? user = userCredential.user;

      // Check if the user exists in Firestore
      final userExists = await FirestoreService(uid: user!.uid).checkUser();

      if (!userExists['exists']) {
        // If the user doesn't exist in Firestore, create a new document for them
        await FirestoreService(uid: user.uid).updateUserData(
            user.displayName!,
            user.photoURL ??
                'https://ui-avatars.com/api/?name=${user.displayName}&color=7F9CF5&background=EBF4FF',
            'member',
            user.phoneNumber ?? '',
            '',
            'Select last education',
            'Have been working?',
            '',
            {'type': 'Basic', 'join_since': Timestamp.now()});
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //forgot password
  Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Link has been send into $email';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
