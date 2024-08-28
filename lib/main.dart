import 'package:flutter/material.dart';
import 'package:the_wall/pages/login_page.dart';

void main() {
  runApp(const TheWall());
}

class TheWall extends StatelessWidget {
  const TheWall({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SanFrancisco',
      ),
      home: const LoginPage(),
    );
  }
}
