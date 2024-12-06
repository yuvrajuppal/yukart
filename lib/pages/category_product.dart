import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:yukart/services/database.dart';
import 'package:yukart/pages/product_detail.dart';
class categoryproduct extends StatefulWidget {
  
  // const categoryproduct({super.key});
      categoryproduct({required this.categorysss});
  String categorysss;

  @override
  State<categoryproduct> createState() => _categoryproductState();
}


class _categoryproductState extends State<categoryproduct> {
  Stream? categorystream;

  getonload()async{
      categorystream = await DatabaseMethods().getproduct(widget.categorysss);
      setState(() {
        
      });
  }
  
  
  


  

  Widget appproducts(){
  return StreamBuilder(stream: categorystream, builder: (context, AsyncSnapshot snapshot){

    return snapshot.hasData? GridView.builder(
      
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6, mainAxisSpacing: 5,crossAxisSpacing: 5),itemCount: snapshot.data.docs.length , itemBuilder: (context,index){
        DocumentSnapshot ds = snapshot.data.docs[index];

        return Container(
          margin: EdgeInsets.all(5),
          height: 250,
          // width: 20,
          // height: 30,
                    // padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:  Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      
                      children: [
                            // Image.networl('images/headphone2.png', height: 140,width: 140,),
                            Image.network(ds["Image"],height: 140,width: 140,),
                            Text(ds["name"],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,

                            ),
                            
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                            
                                Text('\$'+ds["price"], style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),),
                                SizedBox(width: 18,),
                                 GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(detail: ds["detail"], image: ds["Image"],name: ds["name"],price: ds["price"],)));
                                  },
                                   child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.add,color: Colors.white,)),
                                 ),
                              ],
                            )

                      ],
                    ),
                  );
      }):Container();
  });
}

@override
  void initState() {
    // TODO: implement initState

    getonload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
      ),

      body: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
          // height:400,
          // width: 2500, // Give a fixed height
        child: Column(
            children: [
              Expanded(child: appproducts())
            ],
        ),
      ),
    );
  }
}
