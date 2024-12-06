import 'package:flutter/material.dart';
import 'package:yukart/pages/bottomnav.dart';
import 'package:yukart/pages/loginpage.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 53, 214),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Image(
                image: AssetImage(
                  'images/yukart_logo.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'You Got\nWhat to buy\non\nYuKart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => navigationbar_bottom(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: Text(
                        'next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
