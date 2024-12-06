import 'package:flutter/material.dart';
import 'package:yukart/services/database.dart';
import 'package:yukart/widget/support_widget.dart';
import 'package:yukart/pages/category_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukart/services/shared_pref.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yukart/admin/add_product.dart';

// import
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;

  List categories = [
    'images/headphone_icon.png',
    // 'images/headphone.PNG'
    "images/laptop.png",
    "images/TV.png",
    "images/watch.png",
  ];
  List categorynames = [
    'Headphones',
    'Latop',
    'TV',
    'Watch',
  ];

  var tempsearchstory = [];

  initiatesearch(String value) {
    setState(() {
      tempsearchstory = [];
    });

    if (value.isEmpty) {
      setState(() {
        search = false;
      });
      return;
    }

    setState(() {
      search = true;
    });

    DatabaseMethods().search(value).then((QuerySnapshot docs) {
      setState(() {
        tempsearchstory = [];
      });
      for (int i = 0; i < docs.docs.length; i++) {
        setState(() {
          tempsearchstory.add(docs.docs[i].data());
        });
      }
    });
  }

  Widget buildResultcard(data) {
    return Container(
      height: 100,
      child: Row(children: [
        Image.network(
          data["Image"],
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        Text(
          data['name'],
          style: AppWidget.semiboldtextfield(),
        ),
      ]),
    );
  }

  String?  image;

  String name="";

  getsharedpr() async {
    Future<void> saveuserinfotosharepref(String mail) async {
      // Map<String, dynamic> userinfo = {};

      try {
        CollectionReference uservercollection =
            FirebaseFirestore.instance.collection('users');
        QuerySnapshot snapshot =
            await uservercollection.where('Email', isEqualTo: mail).get();

        var userdata = snapshot.docs.first.data();
        // print(userdata);

        Map<String, dynamic> usermap =
            snapshot.docs.first.data() as Map<String, dynamic>;

        String name1 = usermap["Name"].toString();
        //  String email = usermap["Email"].toString();
        String id = usermap["Id"].toString();
        String imageurl = usermap["Image"].toString();
        setState(() {
           name = name1;
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }

       
     
      // image = image2;
    
    }
        String? email = await sharepreferHelper().getUseremail();


    // String? name1 = await sharepreferHelper().getUsername();
    String? image2 = await sharepreferHelper().getUserImage();
    // name = name1;
      image = image2;
    saveuserinfotosharepref(email!.trim());
    setState(() {
      
    });
  }

  onthelod() async {
    await getsharedpr();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    onthelod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name == ""
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey,' + name!,
                            style: AppWidget.boldtextstyle(),
                          ),
                          Text(
                            'Good Morning',
                            style: AppWidget.lighttextstyle(),
                          )
                        ],
                      ),
                      // Image(image: Image.asset('/images/boy.png'))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),

                        // clipBehavior: ,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Image.network(
                            image!,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 209, 209, 209),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        initiatesearch(value);
                        // setState(() {
                        //   initiatesearch(value);
                        // });
                      },
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: AppWidget.lighttextstyle(),
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  search
                      ? ListView.builder(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: tempsearchstory.length,
                          itemBuilder: (context, index) =>
                              buildResultcard(tempsearchstory[index]),
                        )
                      : Padding(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Categories",
                                style: AppWidget.semiboldtextfield(),
                              ),
                              Text(
                                "see all",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 10),
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        height: 90,
                        width: 90,
                        child: Center(
                          child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 0),
                          height: 90,
                          child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return categorytile(
                                image: categories[index],
                                namesofproduct: categorynames[index],
                              );
                            },
                          ),
                          // child: Text('hello world'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Products",
                        style: AppWidget.semiboldtextfield(),
                      ),
                      Text(
                        "see all",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    height: 250,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 209, 209),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/headphone2.png',
                                height: 140,
                                width: 140,
                              ),
                              Text(
                                'Headphone',
                                style: AppWidget.semiboldtextfield(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$100',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 209, 209),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/watch2.png',
                                height: 140,
                                width: 140,
                              ),
                              Text(
                                'Apple Watch',
                                style: AppWidget.semiboldtextfield(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$300',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 209, 209),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/laptop2.png',
                                height: 140,
                                width: 140,
                              ),
                              Text(
                                'Apple Watch',
                                style: AppWidget.semiboldtextfield(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$1200',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // -----------------------------------------------------------------
                ],
              ),
            ),
    );
  }
}

class categorytile extends StatelessWidget {
  String image;
  String namesofproduct;
  categorytile({required this.image, required this.namesofproduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    categoryproduct(categorysss: namesofproduct)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 170, 164, 164),
            borderRadius: BorderRadius.circular(20)),
        height: 90,
        width: 90,
        child: Column(
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
