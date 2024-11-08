import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/profile_post_tile.dart';
import 'package:the_wall/models/post_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          'P R O F I L E',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data!.data()!['username'],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data!.data()!['email'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Your Posts',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<PostModel> postsList = [];
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            var doc = snapshot.data!.docs[i];
                            if (snapshot.data!.docs[i]['email'] ==
                                FirebaseAuth.instance.currentUser!.email) {
                              postsList.add(PostModel.fromJson(
                                snapshot.data!.docs[i],
                                onPressed: () {
                                  var docRef = FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(doc.id);
                                  if ((doc['likes'] as List).contains(
                                      FirebaseAuth
                                          .instance.currentUser!.email)) {
                                    docRef.update({
                                      'likes': FieldValue.arrayRemove([
                                        FirebaseAuth.instance.currentUser!.email
                                      ])
                                    });
                                  } else {
                                    docRef.update({
                                      'likes': FieldValue.arrayUnion([
                                        FirebaseAuth.instance.currentUser!.email
                                      ])
                                    });
                                  }
                                },
                              ));
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListView.builder(
                              itemCount: postsList.length,
                              itemBuilder: (context, index) => ProfilePostTile(
                                postModel: postsList[index],
                                filled: postsList[index].likes.contains(
                                    FirebaseAuth.instance.currentUser!.email),
                                likes: postsList[index].likes.length,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'There was an error, please try again later!',
                              style: TextStyle(
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
                  )
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
