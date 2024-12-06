import 'package:flutter/material.dart';

class adminhomepage extends StatefulWidget {
  const adminhomepage({super.key});

  @override
  State<adminhomepage> createState() => _adminhomepageState();
}

class _adminhomepageState extends State<adminhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
  body: Center(child: Text('admin home page')),
    );
  }
}