import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikesSection extends StatelessWidget {
  const LikesSection(
      {super.key,
      required this.onPressed,
      required this.filled,
      required this.likes});

  final void Function()? onPressed;
  final bool filled;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      likeCount: likes,
      isLiked: filled,
      onTap: (isLiked) async {
        onPressed?.call();
        return !isLiked;
      },
      likeBuilder: (isLiked) => Icon(
        Icons.favorite,
        color: isLiked ? Colors.redAccent : Colors.grey,
        size: 25,
      ),
    );
  }
}
