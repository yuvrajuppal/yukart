import 'package:flutter/material.dart';
import 'package:yukart/pages/home.dart';
import 'package:yukart/pages/loginpage.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/pages/bottomnav.dart';
// import 'clo';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:yukart/services/database.dart';
import 'package:yukart/services/shared_pref.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  String? name, email, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  registration() async {
    if (password != null && name != null && email != null) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        //  String randomId = randomAlphaNumeric(10);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'registered Successfully',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
        String randomId = randomAlphaNumeric(10);

        await sharepreferHelper().saveUseremail(emailcontroller.text);
        await sharepreferHelper().saveUserID(randomId);
        await sharepreferHelper().saveUserName(namecontroller.text);
        await sharepreferHelper().saveUserImage(
            "https://img.freepik.com/premium-photo/stylish-man-flat-vector-profile-picture-ai-generated_606187-310.jpg");

        
        Map<String, dynamic> userinfomap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Id": randomId,
          "Image":
              "https://img.freepik.com/premium-photo/stylish-man-flat-vector-profile-picture-ai-generated_606187-310.jpg"
        };
        await DatabaseMethods().adduserdetials(userinfomap, randomId);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => navigationbar_bottom()));
      } on FirebaseException catch (e) {
        // if(e.code=='weak-password')
        // {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         backgroundColor: Colors.red,

        //         content: Text('Password provided is too Weak',style: TextStyle(fontSize: 20,color: Colors.white),) ));

        // }
        // else if(e.code=="email-already-in-use"){
        //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         backgroundColor: Colors.red,

        //         content: Text('Account already exsists',style: TextStyle(fontSize: 20,color: Colors.white),) ));

        // }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.code,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
      }
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
                              Text('Sign UP', style: AppWidget.boldtextstyle()),
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
                      'Name',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter you name';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: AppWidget.lighttextstyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter you email';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'username or email',
                        hintStyle: AppWidget.lighttextstyle(),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
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
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter you password';
                        }
                        return null;
                      },
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(right: 20),
                  //       child: Text(
                  //         'Forgot Password?',
                  //         style: TextStyle(
                  //             color: Colors.green,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          name = namecontroller.text;
                          email = emailcontroller.text;
                          password = passwordcontroller.text;
                        });
                      }
                      registration();
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
                            'SIGN UP',
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
                      margin: EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
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
