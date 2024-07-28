import 'package:dartz/dartz.dart';
import 'package:news_app/domain/core/auth_failures.dart';

abstract class AuthFacade {
  Future<Either<AuthFailure, Unit>> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> login({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
