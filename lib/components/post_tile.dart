import 'package:flutter/material.dart';
import 'package:the_wall/models/post_model.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.postModel});

  final PostModel postModel;

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
          title: Text(
            postModel.message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${postModel.email}  •  ${postModel.date}',
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
