import 'package:flutter/material.dart';
import 'package:yukart/pages/home.dart';
import 'package:yukart/pages/order.dart';
import 'package:yukart/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class navigationbar_bottom extends StatefulWidget {
  const navigationbar_bottom({super.key});

  @override
  State<navigationbar_bottom> createState() => _navigationbar_bottomState();
}

class _navigationbar_bottomState extends State<navigationbar_bottom> {
  late List<Widget> pages;
  late Home Homepage;
  late Order Orderpage;
  late Profile ProfilePage;
  int currentindex = 0;
  @override
  void initState() {
    // TODO: implement initState

    Homepage = Home();
    ProfilePage = Profile();
    Orderpage = Order();
    pages = [Homepage, Orderpage, ProfilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 350),
        onTap: (int index){
          setState(() {
                     currentindex=index;
 
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],
        
      ),
      body: pages[currentindex],
    );
  }
}
