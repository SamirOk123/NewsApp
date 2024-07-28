import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/domain/auth_facade.dart';
import 'package:news_app/domain/core/auth_failures.dart';

@LazySingleton(as: AuthFacade)
class AuthRepository implements AuthFacade {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<AuthFailure, Unit>> login(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const AuthFailure.userNotFound());
      } else if (e.code == 'wrong-password') {
        return left(const AuthFailure.wrongPassword());
      } else if (e.code == 'invalid-credential') {
        return left(const AuthFailure.invalidUser());
      } else if (e.code == 'invalid-email') {
        return left(const AuthFailure.invalidEmail());
      } else {
        return left(const AuthFailure.serverFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signup(
      {required String name,
      required String email,
      required String password}) async {
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
      }
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else if (e.code == 'invalid-email') {
        return left(const AuthFailure.invalidEmail());
      } else if (e.code == 'weak-password') {
        return left(const AuthFailure.invalidEmail());
      } else {
        return left(const AuthFailure.serverFailure());
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
