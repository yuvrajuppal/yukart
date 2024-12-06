// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authmethod{
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future Signout()async{
    await FirebaseAuth.instance.signOut();
  }

   Future deleteuser()async{
    User? user =  await FirebaseAuth.instance.currentUser;
user?.delete();
  } 
  

}