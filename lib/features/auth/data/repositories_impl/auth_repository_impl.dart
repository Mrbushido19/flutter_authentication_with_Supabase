import 'package:auth_supabase/core/error/exceptions.dart';
import 'package:auth_supabase/core/error/failure.dart';
import 'package:auth_supabase/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:auth_supabase/features/auth/domain/entities/user.dart';
import 'package:auth_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, User>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userData = await _remoteDataSource.logInWithEmailAndPassword(
          email: email, password: password);
      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await _remoteDataSource.signUpWithEmailAndPassword(
          email: email, name: name, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
