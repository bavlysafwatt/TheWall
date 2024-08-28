import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/custom_drawer.dart';
import 'package:the_wall/components/custom_textfield.dart';
import 'package:the_wall/components/post_tile.dart';
import 'package:the_wall/models/post_model.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController message = TextEditingController();

  void postMessage() {
    FirebaseFirestore.instance.collection('posts').add({
      'email': FirebaseAuth.instance.currentUser!.email,
      'message': message.text,
      'date': Timestamp.now(),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PostModel> postsList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              postsList.add(PostModel.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
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
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context, index) => PostTile(
                        postModel: postsList[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'There was an error, please try again later!',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey.shade600,
                backgroundColor: Colors.grey.shade500,
              ),
            );
          }
        },
      ),
    );
  }
}
