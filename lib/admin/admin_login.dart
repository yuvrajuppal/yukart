import 'package:flutter/material.dart';
import 'package:yukart/pages/home.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/pages/bottomnav.dart';
import 'package:yukart/admin/admin_home_page.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.red//

                ),
            width: double.infinity,
            margin: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'images/yukart_logo.png',
                      height: 400,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text('Admin Panel',
                            style: AppWidget.boldtextstyle()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    'User',
                    style: AppWidget.boldtextstyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextFormField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                      hintText: 'username',
                      hintStyle: AppWidget.lighttextstyle(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    'Password',
                    style: AppWidget.boldtextstyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: AppWidget.lighttextstyle(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {

                    loginadmin();
                    // if(_formkey.currentState!.validate()){
                    //    setState(() {
                    //     email = emailcontroller.text;
                    //     password = passwordcontroller.text;
                    //   });
                    //   userLoginogi();
                    // }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  loginadmin() {
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "wrond username",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )));
        }
         else if (result.data()['password'] != passwordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "wrond password",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )));
        }
         else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "login sucressful",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )));


              Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhomepage()));
        }

      });
    });
  }
}
