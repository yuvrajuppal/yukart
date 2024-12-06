import 'package:flutter/material.dart';
import 'package:yukart/pages/loginpage.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:yukart/services/shared_pref.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/services/database.dart';
import 'package:yukart/pages/auth.dart';
import "package:yukart/pages/landingpage.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;

  getthesharedpref() async {
    image = await sharepreferHelper().getUserImage();
    name = await sharepreferHelper().getUsername();
    email = await sharepreferHelper().getUseremail();
    setState(() {});
  }

  @override
  void initState() {
    getthesharedpref();
    // TODO: implement initState
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  File? selectedimage;

  Future getimage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedimage = File(image!.path);
    uploaditem();
    setState(() {});
  }

  uploaditem() async {
    if (selectedimage != null) {
      String addid = randomAlphaNumeric(10);
      Reference firebasestorageref =
          FirebaseStorage.instance.ref().child("blogImage").child(addid);
      final UploadTask task = firebasestorageref.putFile(selectedimage!);
      var downloadurl = await (await task).ref.getDownloadURL();
      await sharepreferHelper().saveUserImage(downloadurl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.amber,
        title: Text(
          'Profile',
          style: AppWidget.boldtextstyle(),
        ),
      ),
      backgroundColor: Color(0xfff2f2f2),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  selectedimage != null
                      ? Center(
                          child: GestureDetector(
                            onTap: () {
                              getimage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                selectedimage!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            getimage();
                          },
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                image!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: AppWidget.lighttextstyle(),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  name!,
                                  style: AppWidget.semiboldtextfield(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mail",
                                  style: AppWidget.lighttextstyle(),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  child: Text(
                                    email!,
                                    style: AppWidget.semiboldtextfield(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),SizedBox(
                    height: 13,
                  ),
                  GestureDetector(
                    onTap: ()async{

                        await Authmethod().Signout().then((value){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>loginpage()));
                        });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_outlined,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Logout",
                                    style: AppWidget.semiboldtextfield(),
                                  ),
                               
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),  
                  SizedBox(height: 13,) ,
                  GestureDetector(
                    onTap: ()async{
                        await Authmethod().deleteuser().then((value){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Landing()));
                        });

                      // Navigator
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3.0,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                size: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delete Account",
                                    style: AppWidget.semiboldtextfield(),
                                  ),
                               
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
