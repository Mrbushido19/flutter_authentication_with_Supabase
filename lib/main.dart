import 'package:auth_supabase/features/auth/presentation/pages/user_log_in_page.dart';

import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:auth_supabase/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (_) {
      return serviceLocator<AuthBloc>();
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
