import 'package:flutter/material.dart';
import 'package:yukart/admin/add_product.dart';
import 'package:yukart/admin/admin_home_page.dart';
import 'pages/landingpage.dart';
import 'pages/home.dart';
import 'package:yukart/pages/bottomnav.dart';
import 'package:yukart/pages/product_detail.dart';
import 'package:yukart/pages/loginpage.dart';
import 'package:yukart/pages/signuppage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/admin/admin_login.dart';
import 'package:yukart/pages/category_product.dart';
import 'package:stripe_ios/stripe_ios.dart';
import 'package:stripe_android/stripe_android.dart';
import 'package:yukart/services/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yukart/pages/userfullinfo_getter.dart';
void main() async {
  // debugDisableShadows = true;

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishablekey;
  await Firebase.initializeApp();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginpage(),
    );
  }
}
