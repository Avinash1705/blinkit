import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/cartController.dart';
import '../../controllers/subCatgoryController.dart';
import '../../model/GetCategoriesResponseModel.dart';
import '../../model/GetSubCategoryModel.dart';
import '../../model/GetSubCategoryModel.dart' as mySubcategory;
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
    as allVenders;
import '../../vender/controller/AllVenderController.dart';
import '../../vender/venderModels/GetVenderResponseModel.dart';
import '../widgets/uihelper.dart';

class SubCategoryNew extends StatefulWidget {
  // String categoryName = "";
  Data1 data = Data1();

  // SubCategoryNew({required this.categoryName,super.key});
  SubCategoryNew({super.key, required this.data});

  @override
  State<SubCategoryNew> createState() => _SubCategoryNewState();
}

class _SubCategoryNewState extends State<SubCategoryNew> {
  TextEditingController searchController = TextEditingController();
  SubCategoryController subCategoryController = SubCategoryController();
  AllVenderController allVenderController = AllVenderController();

  // late GetSubCategoryModel subCategoryModel;
  List<mySubcategory.Data>? data;
  List<allVenders.Data>? allVenderData;
  bool addBtnActive = true;
  List<int> idList = [3312, 33121];
  // String categoryName = widget.categoryName;

  @override
  void initState() {
    print("jsonLIst" + jsonEncode({'ids': idList}));
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      final responses = await Future.wait([
        subCategoryController.fetchSubCategories(),
        allVenderController.fetchVendors(),
      ]);
      final subCategoryResponse = responses[0] as GetSubCategoryModel;
      final vendorResponse = responses[1] as GetVenderResponseModel;
      setState(() {
        print("check lenght of id ${widget.data.id!.length}");
        if (widget.data.id!.length == 10) {
          //filter data using phone number
          data = subCategoryResponse.data
              ?.where((element) => element.phone == widget.data.id)
              .toList();

          allVenderData = vendorResponse.data ?? [];
        } else {
          data = subCategoryResponse.data
              ?.where((element) => element.categoryId == widget.data.id)
              .toList();

          allVenderData = vendorResponse.data ?? [];
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("data in subcategory ${jsonEncode(data)}");
    var cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.data.categoryName.toString()),
          toolbarHeight: 100,
          backgroundColor: Color(0xfff7Cb45)),
      body: data == null
          // ? data!.isNotEmpty
          ? Center(child: CircularProgressIndicator())
          // : Center(child: Text("No item added in this category"))
          : data!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 60,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(height: 16),
                      UiHelper.CustomText(
                        text: "No items in this category",
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontsize: 18,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Start adding items to see them here.",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // width / height
                  ),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Visibility(
                      child: Container(
                        color:
                            ((int.tryParse(data![index].quantity ?? '0') ?? 0) >
                                    0)
                                ? Colors.white
                                : Colors.black.withOpacity(0.2),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey),
                                ),
                                // child: Image.network(
                                //   data![index].itemImg.toString().trim(),
                                //   fit: BoxFit.cover,
                                // ),
                                child: UiHelper.CustomImageNetworkSubCategory(
                                    img:
                                        data![index].itemImg.toString().trim()),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  UiHelper.CustomText(
                                      text: data![index].itemName.toString(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 8),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  /*filter by comparing phone number*/
                                  showShopName(index),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  UiHelper.CustomImage(img: "timer 4.png"),
                                  SizedBox(width: 5),
                                  UiHelper.CustomText(
                                      text:
                                          "Qty ${data![index].quantity.toString()}",
                                      color: Color(0xff9c9c9c),
                                      fontWeight: FontWeight.normal,
                                      fontsize: 10)
                                ],
                              ),
                              Row(
                                children: [
                                  UiHelper.CustomText(
                                      // text: "₹ ${Random().nextInt(10)}",
                                      text:
                                          "₹ ${data![index].price.toString()}",
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold,
                                      fontsize: 15),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ((int.tryParse(data![index].quantity ??
                                                  '0') ??
                                              0) >
                                          0)
                                      ? UiHelper.CustomButton(() {
                                          if (kDebugMode) {
                                            //existing quantity
                                            print(
                                                "Add to cart clicked ${data![index].quantity}");
                                          }
                                          final currentQtyInCart = int.tryParse(
                                                  cartController
                                                          .items[data![index]
                                                              .id
                                                              .toString()]
                                                          ?.quantity
                                                          .toString() ??
                                                      '0') ??
                                              0;
                                          final availableQty = int.tryParse(
                                                  data![index].quantity ??
                                                      '0') ??
                                              0;
                                          if (cartController
                                                      .items[data![index]
                                                          .id
                                                          .toString()]
                                                      ?.quantity ==
                                                  null ||
                                              (currentQtyInCart + 1) <=
                                                  availableQty) {
                                            cartController.addItem(
                                                data![index].id.toString(),
                                                data![index]
                                                    .itemName
                                                    .toString(),
                                                data![index].itemImg.toString(),
                                                double.parse(data![index]
                                                    .price
                                                    .toString()),
                                                int.parse(data![index]
                                                    .quantity
                                                    .toString()));
                                            InteractiveToast.pop(context,
                                                title: Text(
                                                    "${data![index].itemName.toString()} Added"));
                                          } else {
                                            InteractiveToast.pop(context,
                                                title: Text("cant add more"));
                                          }
                                        })
                                      : Text("Item out of stock"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  showShopName(int index) {
    // print("shopName"+jsonEncode(allVenderData));
    /*filter by comparing phone number*/
    if (allVenderData == null) {
      return UiHelper.CustomText(
          text: "Shop not found",
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontsize: 8);
    }
    for (int i = 0; i < allVenderData!.length; i++) {
      if (data?[index].phone == allVenderData![i].phone) {
        return UiHelper.CustomText(
            text: allVenderData![i].shopName.toString(),
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontsize: 8);
      }
    }
    return UiHelper.CustomText(
        text: "Shop not found",
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontsize: 8);
  }
}
