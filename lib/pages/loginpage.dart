import 'package:flutter/material.dart';
import 'package:yukart/pages/home.dart';
import 'package:yukart/pages/landingpage.dart';
import 'package:yukart/pages/signuppage.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/pages/bottomnav.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String email = "", password = "";
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    if (!context.mounted) {
      return;
    }
    try {
      Future<void> saveuserinfotosharepref(String mail) async {
        // Map<String, dynamic> userinfo = {};

        try {
          CollectionReference uservercollection =
              FirebaseFirestore.instance.collection('users');
          QuerySnapshot snapshot =
              await uservercollection.where('Email', isEqualTo: mail).get();

          var userdata = snapshot.docs.first.data();
          print(userdata);

          Map<String, dynamic> usermap =
              snapshot.docs.first.data() as Map<String, dynamic>;

          String name = usermap["Name"].toString();
          //  String email = usermap["Email"].toString();
          String id = usermap["Id"].toString();
          String imageurl = usermap["Image"].toString();

          await sharepreferHelper().saveUseremail(emailcontroller.text);
          await sharepreferHelper().saveUserID(id);
          await sharepreferHelper().saveUserName(name);
          await sharepreferHelper().saveUserImage(imageurl);
        } catch (e) {
          print("Error fetching user data: $e");
        }
      }

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      saveuserinfotosharepref(emailcontroller.text);
     
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(

          backgroundColor: Colors.red,
          content: Text(
            'login Successfully',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.code,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.red
                ),
            width: double.infinity,
            margin: EdgeInsets.only(top: 40),
            child: Form(
              key: _formkey,
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
                          child:
                              Text('Sign In', style: AppWidget.boldtextstyle()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Please enter the details  below to\n                        continue',
                      style: AppWidget.lighttextstyle(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Email',
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
                      controller: emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter you email of username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'username or email',
                        hintStyle: AppWidget.lighttextstyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
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
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter you password';
                        }
                        return null;
                      },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = emailcontroller.text;
                          password = passwordcontroller.text;
                        });
                        userLogin();
                      }
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
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have a account? ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signuppage()));
                            },
                            child: Text(
                              'Sign UP',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
