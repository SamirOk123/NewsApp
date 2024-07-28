import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();
  const factory AuthFailure.invalidEmail() = InvalidEmail;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.weekPassword() = WeekPassword;
  const factory AuthFailure.invalidUser() = InvalidUser;
  const factory AuthFailure.userNotFound() = UserNotFound;
  const factory AuthFailure.wrongPassword() = WrongPassword;
  const factory AuthFailure.clientFailure() = ClientFailure;
  const factory AuthFailure.serverFailure() = ServerFailure;
}
