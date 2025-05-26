
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/cartController.dart';

import '../../controllers/appDetails/appDetails.dart';
import '../widgets/uihelper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  var data = [
    {"img": "image 50.png", "text": "Lights, Diyas \n & Candles"},
    {"img": "image 51.png", "text": "Diwali \n Gifts"},
    {"img": "image 52.png", "text": "Appliances  \n & Gadgets"},
    {"img": "image 53.png", "text": "Home \n & Living"},
    {"img": "image 53.png", "text": "Home \n & Living"},
    {"img": "image 53.png", "text": "Home \n & Living"},
  ];

  var categroy = [
    {
      "id": 1,
      "price": 101,
      "img": "image 54.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
    {
      "id": 2,
      "price": 102,
      "img": "image 57.png",
      "text": "Royal Gulab Jamun\n By Bikano\n"
    },
    {
      "id": 3,
      "price": 103,
      "img": "image 63.png",
      "text": "Applicances \n & Gadgets\n"
    },
    {
      "id": 4,
      "price": 104,
      "img": "image 63.png",
      "text": "Bikaji Bhujia\n \n"
    },
    {
      "id": 5,
      "price": 105,
      "img": "image 63.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
    {
      "id": 6,
      "price": 106,
      "img": "image 63.png",
      "text": "Golden Glass\n Wooden Lid Candle (Oudh)"
    },
  ];

  var grocerykitchen = [
    {"img": "image 41.png", "text": "Vegetables & \nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal & \nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee & \nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread & \nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"}
  ];

  // var appDetailController = Get.put(AppDetails());
  late var dataLoaded = "";

  @override
  void initState() {
    // appDetailController.fe
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartController =
        Provider.of<CartController>(context); // 👈 Access the model

    print("cheking api on ui ${AppDetails.fetchProducts()}");
    return SingleChildScrollView(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  color: Color(0xffec0505),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          UiHelper.CustomText(
                              text: "Blinkit In",
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.bold,
                              fontsize: 15,
                              fontfamily: "bold")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          UiHelper.CustomText(
                              text: "15 minutes",
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.bold,
                              fontsize: 20,
                              fontfamily: "bold")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          UiHelper.CustomText(
                              text: "HOME-",
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.bold,
                              fontsize: 14,
                              fontfamily: "bold"),
                          UiHelper.CustomText(
                              text: "Kursi Road Lucknow(Avinash)",
                              color: Color(0xFFffffff),
                              fontWeight: FontWeight.bold,
                              fontsize: 14,
                              fontfamily: "bold")
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 20,
                    bottom: 100,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
                Positioned(
                    bottom: 30,
                    left: 20,
                    child: UiHelper.CustomTextField(controller: controller)),
              ],
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Color(0xffec0505),
            ),
            Container(
              height: 196,
              width: double.infinity,
              color: Color(0xffec0505),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      UiHelper.CustomImage(img: "image 60.png"),
                      UiHelper.CustomImage(img: "image 55.png"),
                      UiHelper.CustomText(
                          text: "Mega Diwali Sale",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                          fontfamily: "bold"),
                      UiHelper.CustomImage(img: "image 55.png"),
                      UiHelper.CustomImage(img: "image 61.png"),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 1, bottom: 1),
                              child: Container(
                                height: 108,
                                width: 86,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffead303)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      UiHelper.CustomText(
                                          text: data[index]["text"].toString(),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 10),
                                      UiHelper.CustomImage(
                                          img: data[index]["img"].toString())
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: categroy.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Flexible(
                              child: Column(
                                children: [
                                  UiHelper.CustomImage(
                                      img: categroy[index]["img"].toString()),
                                  SizedBox(height: 5),
                                  UiHelper.CustomText(
                                      text: categroy[index]["text"].toString(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 8),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      UiHelper.CustomImage(img: "timer 4.png"),
                                      SizedBox(width: 5),
                                      UiHelper.CustomText(
                                          text: "17 min",
                                          color: Color(0xff9c9c9c),
                                          fontWeight: FontWeight.normal,
                                          fontsize: 10)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.CustomText(
                                          // text: "₹ ${Random().nextInt(10)}",
                                          text: "₹ ${categroy[index]["price"].toString()}",
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.bold,
                                          fontsize: 15),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      UiHelper.CustomButton(() {
                                        cartController.addItem(
                                            categroy[index]["id"].toString(),
                                            categroy[index]["text"].toString(),
                                            categroy[index]["img"].toString(),
                                            double.parse(categroy[index]["price"].toString()));

                                        Get.snackbar(
                                            22.toString(),
                                            "Item added");
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                UiHelper.CustomText(
                    text: "Grocery & Kichen",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontsize: 14,
                    fontfamily: "bold")
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 78,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFD9EBEB)),
                              child: UiHelper.CustomImage(
                                  img: grocerykitchen[index]["img"].toString()),
                            ),
                            UiHelper.CustomText(
                                text: grocerykitchen[index]["text"].toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: grocerykitchen.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
