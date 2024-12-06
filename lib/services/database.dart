// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukart/admin/add_product.dart';

class DatabaseMethods {
  Future adduserdetials(
    Map<String, dynamic> userinfomap,
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userinfomap);
  }

  Future AddProductsforsearch(
    Map<String, dynamic> userinfomap,
    // String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userinfomap);
  }

  Future addProduct(
    Map<String, dynamic> userinfomap,
    String categoryname,
  ) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userinfomap);
    // .set(userinfomap);
  }

  Future<Stream<QuerySnapshot>> getproduct(String category) async {
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future<Stream<QuerySnapshot>> getoders(String email) async {
    return FirebaseFirestore.instance
        .collection("Orders")
        .where("mail", isEqualTo: email)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getodersinadmin() async {
    return FirebaseFirestore.instance
        .collection("Orders")
        // .where("mail", isEqualTo: email)
        .snapshots();
  }

  Future oderdetails(
    Map<String, dynamic> userinfomap,
    // String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        // .doc(id)
        .add(userinfomap);
  }

  upstatus(String id) async {
    return await FirebaseFirestore.instance
        .collection('Orders')
        .doc(id)
        .update({"productstatus": "Delivered"});
  }

 Future<QuerySnapshot> search(String updatedname) async {
    return await FirebaseFirestore.instance
        .collection('Products')
        .where('searchkey',
            isEqualTo: updatedname.substring(0, 1).toUpperCase())
        .get();
  }




  Future<Stream<QuerySnapshot>> getuserdetails(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("mail", isEqualTo: email)
        .snapshots();
  }
}
