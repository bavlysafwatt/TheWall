import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/pages/chat_page.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.username, required this.email});

  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(
            recieverUsername: username,
            recieverEmail: email,
            senderEmail: FirebaseAuth.instance.currentUser!.email!,
          ),
        )),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                Icons.person_rounded,
                color: Colors.grey.shade800,
                size: 30,
              ),
            ),
            title: Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              email,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
