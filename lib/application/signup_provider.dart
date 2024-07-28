import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/domain/auth_facade.dart';
import 'package:news_app/domain/core/auth_failures.dart';

@injectable
class SignupProvider extends ChangeNotifier {
  SignupProvider({required this.authFacade});
  final AuthFacade authFacade;

  bool isSubmitting = false;
  String email = '';
  String password = '';
  String name = '';
  Option<Either<AuthFailure, Unit>> authFailureOrSuccess = const None();

  void emailChanged({required String email}) {
    this.email = email;
    authFailureOrSuccess = none();
    notifyListeners();
  }

  void passwordChanged({required String password}) {
    this.password = password;
    authFailureOrSuccess = none();

    notifyListeners();
  }

  void nameChanged({required String name}) {
    this.name = name;
    authFailureOrSuccess = none();
    notifyListeners();
  }

  Future<void> signup() async {
    isSubmitting = true;
    authFailureOrSuccess = none();
    notifyListeners();
    final failureOrSuccess =
        await authFacade.signup(name: name, email: email, password: password);
    isSubmitting = false;
    authFailureOrSuccess = some(failureOrSuccess);
    notifyListeners();
  }

  void clearState() {
    authFailureOrSuccess = none();
    email = '';
    password = '';
    notifyListeners();
  }
}
