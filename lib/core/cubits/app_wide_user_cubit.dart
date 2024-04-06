import 'package:auth_supabase/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_wide_user_state.dart';

class AppWideUserCubit extends Cubit<AppWideUserState> {
  AppWideUserCubit() : super(AppWideUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppWideUserInitial());
    } else {
      emit(AppWideUserLogged(user));
    }
  }
}
