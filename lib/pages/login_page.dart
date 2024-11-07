// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:the_wall/components/custom_button.dart';
import 'package:the_wall/components/custom_textfield.dart';
import 'package:the_wall/cubits/login_cubit/login_cubit.dart';
import 'package:the_wall/helper_functions.dart';
import 'package:the_wall/pages/home_page.dart';
import 'package:the_wall/pages/register_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String? email;

  String? password;

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          color: Colors.grey.shade500,
          progressIndicator: CircularProgressIndicator(
            color: Colors.grey.shade600,
          ),
          child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Welcome back, you have been missed!',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomFormTextField(
                        onChanged: (value) {
                          email = value;
                        },
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (value) {
                          password = value;
                        },
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        text: 'Login',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .tryToLogin(email: email!, password: password!);
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            )),
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
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
