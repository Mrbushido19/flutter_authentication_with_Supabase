import 'package:auth_supabase/core/error/failure.dart';
import 'package:auth_supabase/core/use_cases/use_case.dart';
import 'package:auth_supabase/core/common/entities/user.dart';
import 'package:auth_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserLogIn implements UseCases<User, UserLogInParams> {
  final AuthRepository _authRepository;

  UserLogIn(this._authRepository);
  @override
  Future<Either<Failure, User>> call(UserLogInParams params) async {
    return await _authRepository.logInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams(this.email, this.password);
}
