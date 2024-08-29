import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_wall/models/post_model.dart';

class ProfilePostTile extends StatelessWidget {
  const ProfilePostTile({super.key, required this.postModel, this.onPressed});

  final PostModel postModel;
  final void Function()? onPressed;

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
              '${postModel.email}  •  ${getDate()}',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
