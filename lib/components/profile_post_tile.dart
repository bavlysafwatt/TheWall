import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:the_wall/models/post_model.dart';

class ProfilePostTile extends StatelessWidget {
  const ProfilePostTile({super.key, required this.postModel});

  final PostModel postModel;

  String getDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        postModel.date.millisecondsSinceEpoch);
    return DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          children: [
            SlidableAction(
              onPressed: (context) async {
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postModel.id)
                    .delete();
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
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
          ),
        ),
      ),
    );
  }
}
