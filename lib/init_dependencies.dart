import 'package:auth_supabase/core/cubits/app_wide_user_cubit.dart';
import 'package:auth_supabase/core/secret/app_secret.dart';
import 'package:auth_supabase/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:auth_supabase/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:auth_supabase/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/current_user.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/user_log_in.dart';
import 'package:auth_supabase/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabasekey);

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppWideUserCubit());
}

void _initAuth() async {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));

  serviceLocator
      .registerFactory<UserSignUp>(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory<UserLogIn>(() => UserLogIn(serviceLocator()));
  serviceLocator
      .registerFactory<CurrentUser>(() => CurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
        signUp: serviceLocator(),
        logIn: serviceLocator(),
        currentUser: serviceLocator(),
        appWideUserCubit: serviceLocator()),
  );
}
