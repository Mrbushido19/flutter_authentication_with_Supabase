import 'package:auth_supabase/core/common/entities/user.dart';
import 'package:auth_supabase/core/cubits/app_wide_user_cubit.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/current_user.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/user_log_in.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _signUp;
  final UserLogIn _logIn;
  final CurrentUser _currentUser;
  final AppWideUserCubit _appWideUserCubit;

  AuthBloc(
      {required UserSignUp signUp,
      required UserLogIn logIn,
      required CurrentUser currentUser,
      required AppWideUserCubit appWideUserCubit})
      : _signUp = signUp,
        _logIn = logIn,
        _currentUser = currentUser,
        _appWideUserCubit = appWideUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
    on<AuthGetCurrentUser>(_onAuthGetCurrentUser);
  }

  void _onAuthSignUp(event, emit) async {
    final res = await _signUp(
        UserSignUpParams(event.name, event.email, event.password));

    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitSuccess(user, emit));
  }

  void _onAuthLogin(event, emit) async {
    final res = await _logIn(UserLogInParams(event.email, event.password));

    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitSuccess(user, emit));
  }

  void _onAuthGetCurrentUser(event, emit) async {
    final res = await _currentUser(NoParams());

    res.fold((failure) => emit(AuthFailure(failure.message)), (user) {
      return _emitSuccess(user, emit);
    });
  }

  void _emitSuccess(User user, Emitter<AuthState> emit) {
    _appWideUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
