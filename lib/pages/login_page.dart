// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/custom_button.dart';
import 'package:the_wall/components/custom_textfield.dart';
import 'package:the_wall/helper_functions.dart';
import 'package:the_wall/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  size: 70,
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
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        // Navigator.pushNamed(context, 'homePage',
                        //     arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'invalid-credential') {
                          showSnackBar(context,
                              'Wrong credential provided for that user.');
                        } else {
                          showSnackBar(
                              context, 'Can\'t login now, try again later');
                        }
                      } catch (e) {
                        showSnackBar(context, 'Error, please try again later!');
                      }
                      setState(() {
                        isLoading = false;
                      });
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
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
    );
  }
}
