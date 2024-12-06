import 'package:flutter/material.dart';
import 'package:yukart/services/database.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:yukart/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class allorders extends StatefulWidget {
  const allorders({super.key});

  @override
  State<allorders> createState() => _allordersState();
}

class _allordersState extends State<allorders> {
  Stream? oderstream;

  getontheload() async {
    // await getsharedpr();
    oderstream = await DatabaseMethods().getodersinadmin();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allorders() {
    return StreamBuilder(
      stream: oderstream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No orders found in the database.'));
        } else if (snapshot.data.docs.isEmpty) {
          return Center(child: Text('No orders doc is empty.'));
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            ds["image"],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Name : " + ds['name'],
                                style: AppWidget.semiboldtextfield(),
                                softWrap:
                                    true, // Ensures the text wraps when it's too long
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,

                                  margin: EdgeInsets.only(left: 10),
                                  // width: MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "Email :",
                                    style: AppWidget.lighttextstyle(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    ds['mail'],
                                    style: AppWidget.lighttextstyle(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 10),
                                  // width: MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "Product :",
                                    style: AppWidget.lighttextstyle(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    ds['product'],
                                    style: AppWidget.lighttextstyle(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,

                                  margin: EdgeInsets.only(left: 10),
                                  // width: MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "Price :",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    "\$" + ds['price'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,

                                  margin: EdgeInsets.only(left: 10),
                                  // width: MediaQuery.of(context).size.width / 1.5,
                                  child: Text(
                                    "Status :",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    ds['productstatus'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                DatabaseMethods().upstatus(ds.id    );
                                setState(() {
                                  
                                });
                              },
                              child: Container(
                                // height: 20,
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10),
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Products",
          style: AppWidget.boldtextstyle(),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(child: allorders()),
            ],
          ),
        ),
      ),
    );
  }
}
