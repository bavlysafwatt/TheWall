import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String email;
  final String message;
  final Timestamp date;
  final String id;
  final List likes;
  final void Function()? onPressed;

  PostModel({
    required this.email,
    required this.message,
    required this.date,
    required this.id,
    required this.likes,
    required this.onPressed,
  });

  factory PostModel.fromJson(jsonData, {onPressed}) {
    return PostModel(
      email: jsonData['email'],
      message: jsonData['message'],
      date: jsonData['date'],
      id: jsonData.id,
      likes: jsonData['likes'],
      onPressed: onPressed,
    );
  }
}
