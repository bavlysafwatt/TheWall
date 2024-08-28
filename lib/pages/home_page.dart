import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_wall/components/custom_drawer.dart';
import 'package:the_wall/components/custom_textfield.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController message = TextEditingController();

  void postMessage() {
    String date = DateFormat.yMMMMEEEEd().format(DateTime.now());
    FirebaseFirestore.instance.collection('posts').add({
      'email': FirebaseAuth.instance.currentUser!.email,
      'message': message.text,
      'date': date,
    });
    message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          'W A L L',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFormTextField(
                    controller: message,
                    hintText: 'Type Something...',
                    obscureText: false,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (message.text.isNotEmpty) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      postMessage();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.grey.shade500,
                      size: 25,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
