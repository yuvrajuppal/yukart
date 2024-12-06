import 'package:flutter/material.dart';
import 'package:yukart/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class userfullinfogetter extends StatefulWidget {
  const userfullinfogetter({super.key});

  @override
  State<userfullinfogetter> createState() => _userfullinfogetterState();
}

class _userfullinfogetterState extends State<userfullinfogetter> {
  Future<void> getemailinfo(String email) async {
    Map<String, dynamic> userinfo = {};

    try {
      CollectionReference uservercollection =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot snapshot =
          await uservercollection.where('Email', isEqualTo: email).get();

      var userdata = snapshot.docs.first.data();
      print(userdata);

      Map<String, dynamic> usernmap =
          snapshot.docs.first.data() as Map<String, dynamic>;

      setState(() {
        name = usernmap["Name"].toString();
        email = email;
        id = usernmap["Id"].toString();
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  // String email="yuvrajuppal84@gmail.com";

  String name = "na";
  String email = "na";
  String id = "na";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('name :'),
            Text(name),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('email :'),
            Text(email),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('id :'),
            Text(id),
          ],
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            child: TextButton(
                onPressed: () {
                  getemailinfo("yuvrajuppal84@gmail.com");
                },
                child: Text("click me")))
      ],
    ));
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getUserByEmail1(String email) async {
  try {
    // Reference the Firestore collection 'users'
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query to find user document by email
    QuerySnapshot snapshot =
        await usersCollection.where('Email', isEqualTo: email).get();

    // Check if any documents were found
    if (snapshot.docs.isNotEmpty) {
      // Get the first document that matches the query
      var userData = snapshot.docs.first.data();
      print("User Data: $userData");

      Map<String, dynamic> userMap =
          snapshot.docs.first.data() as Map<String, dynamic>;

      // Access fields like this:
      String userName = userMap['Name']; // Access the 'Name' field
      String userImage = userMap['Image']; // Access the 'Image' field
      print('Username: $userName \n');
      print('User Image URL: $userImage \n');
    } else {
      print("No user found with email: $email");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getUserByEmail2(String email) async {
  try {
    // Reference the Firestore 'users' collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query to find the user by email
    QuerySnapshot snapshot =
        await usersCollection.where('Email', isEqualTo: email).get();

    // Check if any documents were found
    if (snapshot.docs.isNotEmpty) {
      // Get the first document's data
      var userData = snapshot.docs.first.data();
      print("User Data: $userData");

      // Convert the document data to a Map for easier access
      Map<String, dynamic> userMap =
          snapshot.docs.first.data() as Map<String, dynamic>;

      // Access fields like Name and Image
      String userName = userMap['Name']; // Access 'Name' field
      String userImage = userMap['Image']; // Access 'Image' field
      print('Username: $userName');
      print('User Image URL: $userImage');
    } else {
      print("No user found with email: $email");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}
