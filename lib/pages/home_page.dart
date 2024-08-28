import 'package:flutter/material.dart';
import 'package:the_wall/components/custom_drawer.dart';
import 'package:the_wall/components/custom_textfield.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  String? postMessage;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFormTextField(
                    onChanged: (value) {
                      postMessage = value;
                    },
                    hintText: 'Type Something...',
                    obscureText: false,
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.done,
                    color: Colors.grey.shade500,
                    size: 25,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
