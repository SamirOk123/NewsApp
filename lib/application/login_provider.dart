import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/domain/auth_facade.dart';
import 'package:news_app/domain/core/auth_failures.dart';

@injectable
class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.authFacade});
  final AuthFacade authFacade;
  bool isSubmitting = false;
  String email = '';
  String password = '';
  Option<Either<AuthFailure, Unit>> loginFailureOrSuccess = const None();

// To get email from the onchanged callback of the email textfield
  void emailChanged({required String email}) {
    this.email = email;
    loginFailureOrSuccess = none();
    notifyListeners();
  }

// To get password from the onchanged callback of the password textfield
  void passwordChanged({required String password}) {
    this.password = password;
    loginFailureOrSuccess = none();
    notifyListeners();
  }

  Future<void> login() async {
    isSubmitting = true;
    loginFailureOrSuccess = none();
    notifyListeners();
    final failureOrSuccess =
        await authFacade.login(email: email, password: password);
    isSubmitting = false;
    loginFailureOrSuccess = some(failureOrSuccess);
    notifyListeners();
  }

  Future<void> logout() async {
    await authFacade.signOut();
  }

  void clearState() {
    loginFailureOrSuccess = none();
    email = '';
    password = '';
    notifyListeners();
  }
}
