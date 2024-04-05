import 'package:auth_supabase/core/error/failure.dart';
import 'package:auth_supabase/core/use_cases/use_case.dart';
import 'package:auth_supabase/features/auth/domain/entities/user.dart';
import 'package:auth_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserSignUp implements UseCases<User, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp(this._authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(this.name, this.email, this.password);
}
