import 'package:flutter/material.dart';
import 'package:yukart/widget/support_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukart/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Orderadmin extends StatefulWidget {
  const Orderadmin({super.key});

  @override
  State<Orderadmin> createState() => _Orderadmin();
}

class _Orderadmin extends State<Orderadmin> {
  Stream? oderstream;

  String? emial;

  getsharedpr() async {
    emial = (await sharepreferHelper().getUseremail())?.trim();
    // emial="chacha211@gmail.com";

    // image =  await sharepreferHelper().getUserImage();
    setState(() {});
  }

  getontheload() async {
    await getsharedpr();
    oderstream = await DatabaseMethods().getodersinadmin();
    setState(() {});
  }

  Widget allorders() {
    return StreamBuilder(
      stream: oderstream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text('No orders found.'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          ds["productimage"],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                ds['product'],
                                style: AppWidget.semiboldtextfield(),
                                softWrap:
                                    true, // Ensures the text wraps when it's too long
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                '\$' + ds['price'],
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap:
                                    true, // Ensures the text wraps when it's too long
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    softWrap:
                                        true, // Ensures the text wraps when it's too long
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    ds["productstatus"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    softWrap:
                                        true, // Ensures the text wraps when it's too long
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                ds['mail'],
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap:
                                    true, // Ensures the text wraps when it's too long
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget allorders1() {
    return StreamBuilder(
        stream: oderstream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              ds["image"],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text(
                                      ds['name'],
                                      style: AppWidget.semiboldtextfield(),
                                    )),
                                Text(
                                  '\$' + ds['price'],
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container(
                  child: Text('nana'),
                );
        });
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.amber,
        title: Text(
          'Current orders',
          style: AppWidget.boldtextstyle(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(child: allorders()),

            // Text("Your Email"+emial!)
          ],
        ),
      ),
    );
  }
}
