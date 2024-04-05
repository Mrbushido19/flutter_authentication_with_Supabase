import 'package:auth_supabase/features/auth/domain/entities/user.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _signUp;
  AuthBloc({required UserSignUp signUp})
      : _signUp = signUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _signUp(
          UserSignUpParams(event.name, event.email, event.password));

      res.fold((failure) => emit(AuthFailure(failure.message)),
          (user) => emit(AuthSuccess(user)));
    });
  }
}
