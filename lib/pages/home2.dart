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

// import '';
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
    "images/watch.png"
  ];
  List categorynames = [
    'Headphones',
    'Latop',
    'TV',
    'Watch',
  ];

  var queryResultSet = [];
  var tempsearchstory = [];

  initiatesearch(String value) {
    if (value.isEmpty) {
      setState(() {
        var queryResultSet = [];
        var tempsearchstory = [];
      });
      setState(() {
        search = false;
      });
      return;
    }

    setState(() {
      search = true;
    });

    var capitalizefvalue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    // if (queryResultSet.isEmpty && value.length == 1) {
    DatabaseMethods().search(value).then((QuerySnapshot docs) {
      print(docs.docs.length);
      for (int i = 0; i < docs.docs.length; ++i) {
        queryResultSet.add(docs.docs[i].data());
      }
      for (var element in queryResultSet) {
        if (element['updatedname'].toString().startsWith(capitalizefvalue)) {
          setState(() {
            tempsearchstory.add(element);
          });
        }
      }
    });
    // } else {
    // }
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

  String? name, image;

  getsharedpr() async {
    name = await sharepreferHelper().getUsername();
    image = await sharepreferHelper().getUserImage();
    setState(() {});
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
      body: name == null
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
                        print(value);
                        initiatesearch(value);
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
                      ? ListView(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          primary: false,
                          shrinkWrap: true,
                          children: tempsearchstory.map((element) {
                            return buildResultcard(element);
                          }).toList(),
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
