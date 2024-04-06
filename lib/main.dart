import 'package:auth_supabase/core/cubits/app_wide_user_cubit.dart';
import 'package:auth_supabase/features/auth/presentation/pages/user_log_in_page.dart';

import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:auth_supabase/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) {
      return serviceLocator<AuthBloc>();
    }),
    BlocProvider(create: (_) {
      return serviceLocator<AppWideUserCubit>();
    })
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(
          AuthGetCurrentUser(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocSelector<AuthBloc, AuthState, bool>(
        selector: (state) {
          return state is AppWideUserLogged;
        },
        builder: (context, isLogged) {
          if (isLogged) {
            return const Scaffold(
              body: Center(child: Text("welcome ")),
            );
          }
          return const UserLogInPage();
        },
      ),
    );
  }
}
