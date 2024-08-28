import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/user_tile.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          'U S E R S',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => UserTile(
                  username: snapshot.data!.docs[index]['username'],
                  email: snapshot.data!.docs[index]['email'],
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
    );
  }
}
