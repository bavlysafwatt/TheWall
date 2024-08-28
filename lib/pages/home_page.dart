import 'package:flutter/material.dart';
import 'package:the_wall/components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          'W A L L',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
    );
  }
}
