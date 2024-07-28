import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class TextfieldProvider extends ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  RegExp strongPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  RegExp emailRequirement = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //General Validator
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  emailValidator(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (!emailRequirement.hasMatch(value)) {
      return "Email is not valid";
    } else {
      return null;
    }
  }

  passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (!strongPassword.hasMatch(value)) {
      return "8+ chars, 1 uppercase, 1 lowercase, 1 number, 1 special (e.g., !@#\$&*~)";
    } else {
      return null;
    }
  }

  void showHidePassword() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
