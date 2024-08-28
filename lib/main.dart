import 'package:flutter/material.dart';

void main() {
  runApp(const TheWall());
}

class TheWall extends StatelessWidget {
  const TheWall({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
