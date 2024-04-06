part of 'app_wide_user_cubit.dart';

@immutable
sealed class AppWideUserState {}

final class AppWideUserInitial extends AppWideUserState {}

final class AppWideUserLogged extends AppWideUserState {
  final User user;

  AppWideUserLogged(this.user);
}
