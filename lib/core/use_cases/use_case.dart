import 'package:auth_supabase/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class UseCases<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
