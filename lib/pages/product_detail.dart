import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yukart/services/constant.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukart/services/database.dart';

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? name, email, image;

  getthesharedpef() async {
    name = await sharepreferHelper().getUsername();
    email = await sharepreferHelper().getUseremail();
    image = await sharepreferHelper().getUserImage();
    setState(() {});
  }

  onthload() async {
    await getthesharedpef();
    setState(() {});
  }

  Map<String, dynamic>? paymentintend;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    onthload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 203, 203),
      body: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        // color: Colors.yellow
                        ),
                    child: Container(
                      child: Center(
                        child: Image.network(
                          widget.image,
                          height: 400,
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                // height: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppWidget.boldtextstyle(),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 203, 203, 203),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Text(
                            "\$" + widget.price,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 8, 8, 8),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Details',
                      style: AppWidget.semiboldtextfield(),
                    ),
                    Flexible(
                      child: Container(
                        // height: 250,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          // shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              child: Text(
                                widget.detail,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        makepayment2();
                        // makepayment('200');
                        // makepayment(widget.price);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'Buy now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makepayment2() async {


    
    Map<String, dynamic> oderinfomap = {
      'product': widget.name,
      'price': widget.price,
      'name': name,
      'mail': email,
      'image': image,
      "productimage": widget.image,
      "productstatus":"On the way",



      
    };

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'oder made',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )));

    await DatabaseMethods().oderdetails(oderinfomap);


  }

  Future<void> makepayment(String amount) async {
    try {
      paymentintend = await createpaymentIntent(amount, "INR");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentintend?["client_secret"],
                  style: ThemeMode.dark,
                  merchantDisplayName: "roloxy"))
          .then((value) {
        diaplaymentsheet();
      });
    } catch (e, s) {
      print("exception:$e$s");
    }
  }

  diaplaymentsheet() async {
    try {
      await Stripe.instance.presentCustomerSheet().then((value) async {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("payment successful"),
                        ],
                      )
                    ],
                  ),
                ));
        paymentintend = null;
      }).onError((error, stackTrace) {
        print("error is ----->$error $stackTrace");
      });
    } on StripeException catch (e) {
      print("error is ----> $e");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("payment canceled"),
              ));
    } catch (e) {
      print("$e");
    }
  }

  calculateAmount(String amount) {
    final calculatedamount = (int.parse(amount) * 100);
    return calculatedamount.toInt();
  }

  createpaymentIntent(String amount, String currenry) async {
    try {
      Map<String, dynamic> body = {
        'amount': 300,
        'currency': currenry,
        'payment_method_type[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents/'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user ${err.toString()}');
    }
  }
}
