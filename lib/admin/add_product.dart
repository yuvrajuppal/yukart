import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yukart/services/database.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final ImagePicker _picker = ImagePicker();
  File? selectedimage;

  Future getimage()async{
    var image = await  _picker.pickImage(source: ImageSource.gallery);
    selectedimage = File(image!.path);
    setState(() {
      
      
    });
  }
 
 TextEditingController productnamecontroller = new TextEditingController();
 TextEditingController pricecontroller =  new TextEditingController();
 TextEditingController detailcontroller =  new TextEditingController();

  uploaditem()async{
    if(selectedimage!=null &&productnamecontroller.text!="" ){
      String productname=productnamecontroller.text;
      String productdetail = detailcontroller.text;
      String priceofproduct=pricecontroller.text;
      String firstname =  productnamecontroller.text.substring(0,1).toUpperCase();
      String upadatedname=productnamecontroller.text.toUpperCase();

        String addid = randomAlphaNumeric(10);
        Reference firebasestorageref = FirebaseStorage.instance.ref().child("blogImage").child(addid);
        final UploadTask task =  firebasestorageref.putFile(selectedimage!);
        var downloadurl =  await (await task).ref.getDownloadURL();
        Map<String,dynamic> add_product ={
            "name":productname,
            "Image":downloadurl,
            "price":priceofproduct,
            "detail":productdetail,
            "searchkey": firstname,
            "updatedname":upadatedname,
        };



        await DatabaseMethods().addProduct(add_product, value!).then((value)async{
          await DatabaseMethods().AddProductsforsearch(add_product);
          setState(() {
             selectedimage=null;
          });
          
          productnamecontroller.text="";
          detailcontroller.text="";
          pricecontroller.text="";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("data uploaded",style: TextStyle(fontSize: 20),),
          ));


          
        });

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("add full info",style: TextStyle(fontSize: 20),),
          ));

    }
  }
   List<String> categoryitems = [
    'Watch',
    'Latop',
    'TV',
    'Headphones',
  ];

  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          'Add Product',
          style: AppWidget.semiboldtextfield(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload a Product Image',
                style: AppWidget.lighttextstyle(),
              ),
              SizedBox(
                height: 20,
              ),
              selectedimage==null? GestureDetector(
                onTap: (){
                  getimage();
        
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    height: 150,
                    width: 150,
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ):Material(
                // elevation: 4.0,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(selectedimage!,fit: BoxFit.cover,))
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Product Name',
                style: AppWidget.lighttextstyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFececf8),
                ),
                child: TextField(
                  controller: productnamecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20,),
               Text(
                'Product price',
                style: AppWidget.lighttextstyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFececf8),
                ),
                child: TextField(
                  
                  controller: pricecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
               Text(
                'Product Detail',
                style: AppWidget.lighttextstyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFececf8),
                ),
                child: TextField(
                  
                  maxLines: 8,
                  controller: detailcontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20,),
                Text(
                'Product Category',
                style: AppWidget.lighttextstyle(),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryitems
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,
                                  style: AppWidget.semiboldtextfield()),
                            ))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Center(child: Text("Select Category")),
                    value: value,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: Center(
                  child: ElevatedButton(
                    
                    onPressed: (){
                      uploaditem();
                  
                  }, child: Text('Add product',
                style: TextStyle(
                  fontSize: 20
                ),
                  )),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
