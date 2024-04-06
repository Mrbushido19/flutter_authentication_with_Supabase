import 'package:auth_supabase/core/error/failure.dart';
import 'package:auth_supabase/core/use_cases/use_case.dart';
import 'package:auth_supabase/core/common/entities/user.dart';
import 'package:auth_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CurrentUser implements UseCases<User, NoParams> {
  final AuthRepository _authRepository;

  CurrentUser(this._authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.currentUser();
  }
}

class NoParams {}
