import 'package:auth_supabase/core/error/failure.dart';
import 'package:auth_supabase/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
