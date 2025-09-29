// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:swiggy/ui/category/subCategory.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

// import '../../controllers/cartController.dart';
import '../../controllers/categoriesController.dart';
import '../../controllers/subCatgoryController.dart';
import '../../model/GetCategoriesResponseModel.dart';
import '../../model/GetSubCategoryModel.dart';
import '../../vender/controller/AllVenderController.dart';
import '../../vender/venderModels/GetVenderResponseModel.dart';
import '../widgets/customAppBar.dart';
import 'SubCategoryNew.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
    as allVenders;
import '../../model/GetSubCategoryModel.dart' as mySubcategory;

class Category extends StatefulWidget {
  Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  //SearchController searchController = Get.find<SearchController>();
  TextEditingController searchController = TextEditingController();
  GetCategoriesResponseModel categoriesResponseModel =
      GetCategoriesResponseModel();
  Data1 data1 = Data1.withValues(
      categoryName: "categoryName", categoryImg: "categoryImg", id: "id");

  //array cateory
  var data = [
    {"img": "image 50.png", "text": "Lights, Diyas \n & Candles"},
    {"img": "image 51.png", "text": "Diwali \n Gifts"},
    {"img": "image 52.png", "text": "Appliances  \n & Gadgets"},
    {"img": "image 53.png", "text": "Home \n & Living"}
  ];

  var categroy = [
    {"img": "image 54.png", "text": "Golden Glass\n Wooden Lid Candle (Oudh)"},
    {"img": "image 57.png", "text": "Royal Gulab Jamun\n By Bikano"},
    {"img": "image 63.png", "text": "Golden Glass\n Wooden Lid Candle (Oudh)"},
  ];

  var grocerykitchen = [
    {"img": "image 41.png", "text": "Vegetables & \nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal & \nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee & \nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread & \nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
  ];

  var snakesAndDrinks = [
    {"img": "image 31.png", "text": "Chips & \n Namkeens"},
    {"img": "image 32.png", "text": "Sweets & \nChocalates"},
    {"img": "image 33.png", "text": "Drinks & \nJuices"},
    {"img": "image 34.png", "text": "Sauces & \nSpreads"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 35.png", "text": "Beauty & \nCosmetics"},
  ];

  var houseHoldUtentials = [
    {"img": "image 36.png", "text": "Chips & \n Namkeens"},
    {"img": "image 37.png", "text": "Sweets & \nChocalates"},
    {"img": "image 38.png", "text": "Drinks & \nJuices"},
    {"img": "image 39.png", "text": "Sauces & \nSpreads"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"},
    {"img": "image 40.png", "text": "Beauty & \nCosmetics"}
  ];
  SubCategoryController subCategoryController = SubCategoryController();
  AllVenderController allVenderController = AllVenderController();
  GetCategoriesController categoriesController = GetCategoriesController();
  late List<allVenders.Data>? allVenderData = [];
  late List<allVenders.Data>? allFilteredVenderData = [];
  late List<mySubcategory.Data>? allFilteredSubcategory = [];
  late List<mySubcategory.Data>? allSubcategory = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      final responses = await Future.wait([
        subCategoryController.fetchSubCategories(),
        allVenderController.fetchVendors(),
        categoriesController.getCategories()
      ]);
      final subCategoryResponse = responses[0] as GetSubCategoryModel;
      final vendorResponse = responses[1] as GetVenderResponseModel;
      final categoriesResponse = responses[2] as GetCategoriesResponseModel;
      setState(() {
        allVenderData = vendorResponse.data!;
        allSubcategory = subCategoryResponse.data;
        categoriesResponseModel = categoriesResponse;
        // print("cat all data1 ${jsonEncode(allVenderData)}");
        // print("cat all data2 ${jsonEncode(allSubcategory)}");
        for (int i = 0; i < vendorResponse.data!.length; i++) {
          for (int j = 0; j < allSubcategory!.length; j++) {
            if (vendorResponse.data![i].phone == allSubcategory![j].phone) {
              /*No need to update vender data
            * Show all vender even no items*/
              // allFilteredVenderData!.add(vendorResponse.data![i]);
              allFilteredSubcategory?.add(allSubcategory![j]);
            }
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              // SizedBox(
              //   height: 40,
              // ),
              CustomAppBar(controller: searchController),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Categories Current Present",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 85,
                child: categoriesResponseModel.data == null
                    ? CircularProgressIndicator()
                    : ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        /*converting data to data1*/
                        Get.to(SubCategoryNew(
                          data: Data1.withValues(
                            id: categoriesResponseModel.data![index].id
                                .toString(),
                            categoryName: categoriesResponseModel
                                .data![index].categoryName
                                .toString(),
                            categoryImg: categoriesResponseModel
                                .data![index].categoryImg
                                .toString(),
                          ),
                        ))
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.08,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFD9EBEB)),
                              child: UiHelper.CustomImageNetworkCategory(
                                  img: categoriesResponseModel
                                      .data![index].categoryImg
                                      .toString()),
                            ),
                            UiHelper.CustomText(
                                text: categoriesResponseModel
                                    .data![index].categoryName
                                    .toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: categoriesResponseModel.data!.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Shops Current Present",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              SizedBox(
                height: 85,
                child: allVenderData!.isEmpty
                    ? CircularProgressIndicator()
                    : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => {
                          print(
                              "u clicked on shop${allVenderData![index].shopName}"),
                          /*converting data to data1*/
                          Get.to(SubCategoryNew(
                            data: Data1.withValues(
                              id: allVenderData![index].phone.toString(),
                              categoryName: allVenderData![index]
                                  .shopName
                                  .toString(),
                            ),
                          ))
                        },
                        child: Column(
                          children: [
                            Container(
                                height: 50,
                                width: 71,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Color(0xFFD9EBEB)),
                                child: allVenderData == null
                                    ? Image.asset(
                                  "assets/images/shop.png",
                                  fit: BoxFit.cover,
                                )
                                    : UiHelper.CustomImageNetworkShop(
                                    img: allVenderData![index]
                                        .shop_img
                                        .toString())),
                            UiHelper.CustomText(
                                text: allVenderData![index]
                                    .shopName
                                    .toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontsize: 10)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: allVenderData!.length,
                  scrollDirection: Axis.horizontal,
                ),
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
              SizedBox(
                height: 115,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    );
                  },
                  itemCount: grocerykitchen.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "Household Essentials",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
              SizedBox(
                height: 85,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 78,
                        width: 71,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFD9EBEB)),
                        child: UiHelper.CustomImage(
                            img: houseHoldUtentials[index]["img"].toString()),
                      ),
                    );
                  },
                  itemCount: houseHoldUtentials.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
