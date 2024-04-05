import 'package:auth_supabase/core/secret/app_secret.dart';

import 'package:auth_supabase/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:auth_supabase/features/auth/data/repositories_impl/auth_repository_impl.dart';

import 'package:auth_supabase/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:auth_supabase/features/auth/presentation/pages/user_log_in_page.dart';

import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabasekey);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (_) {
      return AuthBloc(
        signUp: UserSignUp(
          AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(supabase.client),
          ),
        ),
      );
    })
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLogInPage(),
    );
  }
}
