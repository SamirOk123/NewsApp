import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signup(
      {required String email,
      required String password,
      required String name}) async {
    String message = 'Something went wrong';

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'uid': user.uid,
        });

        message = 'Signed up successfully';
      }
      return message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String message = 'Something went wrong';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = 'Logged in successfully';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
