import 'package:auth_supabase/core/common/widgets/loader.dart';
import 'package:auth_supabase/core/utils/show_snack_bar.dart';
import 'package:auth_supabase/features/auth/presentation/pages/user_log_in_page.dart';
import 'package:auth_supabase/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:auth_supabase/features/auth/presentation/widgets/auth_button.dart';
import 'package:auth_supabase/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSignUpPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) {
      return const UserSignUpPage();
    });
  }

  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                        "Sign Up.",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthFormField(
                        controller: _nameController,
                        labelText: "Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthFormField(
                        controller: _emailController,
                        labelText: "Email",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthFormField(
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
                                  AuthSignUp(
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text),
                                );
                          }
                        },
                        buttonText: "Sign Up",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, UserLogInPage.route());
                        },
                        child: RichText(
                            text: const TextSpan(
                                text: "Already have an account?",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                children: [
                              TextSpan(
                                text: "Log In",
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
