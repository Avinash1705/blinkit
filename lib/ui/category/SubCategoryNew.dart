import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/cartController.dart';
import '../../controllers/subCatgoryController.dart';
import '../../model/GetCategoriesResponseModel.dart';
import '../../model/GetSubCategoryModel.dart';
import '../../model/GetSubCategoryModel.dart' as mySubcategory;
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
    as allVenders;
import '../../vender/controller/AllVenderController.dart';
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
  late List<mySubcategory.Data>? data = [];
  late List<allVenders.Data>? allVenderData;

  // String categoryName = widget.categoryName;
  @override
  void initState() {
    subCategoryController.fetchSubCategories().then((value) => setState(() {
          print(value.data!.first.phone);
          data = value.data
              ?.where((element) => element.categoryId == widget.data.id)
              .toList();
        }));
    allVenderController.fetchVendors().then((value) {
      setState(() {
        // for(int i=0;i<value.data!.length;i++){
        //   print("Vender Name: ${value.data![i].shopName}");
        // }
        allVenderData = value.data!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.data.categoryName.toString()),
          toolbarHeight: 100,
          backgroundColor: Color(0xfff7Cb45)),
      body: data == null
          ? data!.isNotEmpty
              ? CircularProgressIndicator()
              : Center(child: Text("No item added in this category"))
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
                return Container(
                  color: Colors.white,
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Flexible(
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
                              child: Image.network(
                                data![index].itemImg.toString(),
                                fit: BoxFit.cover,
                              ),
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
                                    text: "₹ ${data![index].price.toString()}",
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold,
                                    fontsize: 15),
                                SizedBox(
                                  width: 10,
                                ),
                                UiHelper.CustomButton(() {
                                  if (kDebugMode) {
                                    print("Item added to cart");
                                  }
                                  // print(
                                  //     "Item added to cart ${data![index].quantity.toString()}");
                                  // Add item to cart
                                  // print("cart item cheking ${jsonEncode(data![index])}");
                                  cartController.addItem(
                                      data![index].id.toString(),
                                      data![index].itemName.toString(),
                                      data![index].itemImg.toString(),
                                      double.parse(
                                          data![index].price.toString()),
                                      int.parse(
                                          data![index].quantity.toString()));
                                  InteractiveToast.pop(context,
                                      title: Text(
                                          "${data![index].itemName.toString()} Added"));
                                }),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
    );
  }

  showShopName(int index) {
    /*filter by comparing phone number*/
    for (int i = 0; i < allVenderData!.length; i++) {
      if (data?[index].phone == allVenderData![i].phone) {
        return UiHelper.CustomText(
            text: allVenderData![i].shopName.toString(),
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontsize: 8);
      }
    }
  }
}
