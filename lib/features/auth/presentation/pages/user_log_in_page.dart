import 'package:auth_supabase/core/common/widgets/loader.dart';
import 'package:auth_supabase/core/utils/show_snack_bar.dart';
import 'package:auth_supabase/features/auth/presentation/pages/user_sign_up_page.dart';
import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:auth_supabase/features/auth/presentation/widgets/auth_button.dart';
import 'package:auth_supabase/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLogInPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) {
      return UserLogInPage();
    });
  }

  const UserLogInPage({super.key});

  @override
  State<UserLogInPage> createState() => _UserLogInPageState();
}

class _UserLogInPageState extends State<UserLogInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock,
                        size: 50,
                        weight: 3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Log In.",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthFormField(
                        isObscure: false,
                        controller: _emailController,
                        labelText: "Email",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthFormField(
                        isObscure: true,
                        controller: _passwordController,
                        labelText: "Password",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLogIn(_emailController.text,
                                      _passwordController.text),
                                );
                          }
                        },
                        buttonText: "Log In",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, UserSignUpPage.route());
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
