import 'package:flutter/material.dart';
import 'package:the_wall/components/custom_button.dart';
import 'package:the_wall/components/custom_textfield.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? username;

  String? email;

  String? password;

  String? confirmPassword;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 80),
                const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.black,
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Let\'s create an account for you!',
                    style: TextStyle(
                      fontFamily: 'Inter',
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
                        fontFamily: 'Roboto',
                        color: Colors.grey.shade600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(context),
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
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
