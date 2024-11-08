import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_wall/components/likes_section.dart';
import 'package:the_wall/models/post_model.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.postModel,
    required this.filled,
    required this.likes,
  });

  final PostModel postModel;
  final bool filled;
  final int likes;

  String getDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        postModel.date.millisecondsSinceEpoch);
    return DateFormat.yMMMMd().format(dateTime);
  }

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
        child: Column(
          children: [
            ListTile(
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
                  '${postModel.email}  •  ${getDate()}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
            LikesSection(
              onPressed: postModel.onPressed,
              filled: filled,
              likes: likes,
            ),
          ],
        ),
      ),
    );
  }
}
