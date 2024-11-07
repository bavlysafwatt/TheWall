// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:the_wall/components/custom_button.dart';
import 'package:the_wall/components/custom_textfield.dart';
import 'package:the_wall/cubits/register_cubit/register_cubit.dart';
import 'package:the_wall/helper_functions.dart';
import 'package:the_wall/pages/home_page.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  String? username;

  String? email;

  String? password;

  String? confirmPassword;

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading,
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
                  child: ListView(
                    children: [
                      const SizedBox(height: 85),
                      const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Let\'s create an account for you!',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomFormTextField(
                        onChanged: (value) {
                          username = value;
                        },
                        hintText: 'Username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (data) {
                          confirmPassword = data;
                        },
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        text: 'Register',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .tryToRegister(
                              username: username!,
                              email: email!,
                              password: password!,
                              confirmPassword: confirmPassword!,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(context),
                            child: Text(
                              'Login now',
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
