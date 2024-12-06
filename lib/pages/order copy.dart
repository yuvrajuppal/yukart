import 'package:flutter/material.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukart/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukart/services/shared_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? oderstream;

  String? emial;


    getsharedpr()async{
      emial =  await sharepreferHelper().getUseremail();
      // image =  await sharepreferHelper().getUserImage();
      setState(() {
        
      });
  }

getontheload()async{
  await getsharedpr();
oderstream = await DatabaseMethods().getoders(emial!);
setState(() {
  
});

}





  Widget allorders() {
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
                                  '\$'+ds['price'],
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
              : Container(child: Text('nana'),);
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
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.amber,
        title: Text(
          'Current orders',
          style: AppWidget.boldtextstyle(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
           Expanded(child: allorders()),

  TextButton(onPressed: (){print(emial);}, child: Text('hello'))
       
          ],
        ),



      
      ),
    );
  }
}
