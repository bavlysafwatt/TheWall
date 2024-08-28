import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(12),
        child: ListTile(
          title: const Text(
            'FIRST POST!!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'bavlysafwatt@gmail.com • 28/8/2024',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
