import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:provider/provider.dart';

import '../../controllers/cartController.dart';
import '../../controllers/subCatgoryController.dart';
import '../../model/GetCategoriesResponseModel.dart';
import '../../model/GetSubCategoryModel.dart';
import '../../model/GetSubCategoryModel.dart' as mySubcategory;
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
   // late GetSubCategoryModel subCategoryModel;
  late List<mySubcategory.Data>? data;
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
  // String categoryName = widget.categoryName;
  @override
  void initState() {
    subCategoryController.fetchSubCategories().then((value) =>setState(() {
      data = value.data?.where((element) => element.categoryId == widget.data.id).toList();
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.data.categoryName.toString()),toolbarHeight: 100,backgroundColor: Color(0xfff7Cb45)),
      body: data!.isEmpty  ? Center(child: Text("No item added in this category")):GridView.builder(
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
            child:  Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: Flexible(
                  child: Column(
                    children: [
                      // UiHelper.CustomImage(
                      //     img: categroy[index]["img"]
                      //         .toString()),
                      UiHelper.CustomImageNetwork(img: data![index].itemImg.toString(), height: 100, width: 100),
                      SizedBox(height: 5),
                      UiHelper.CustomText(
                          text: data![index].itemName
                              .toString(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 8),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          UiHelper.CustomImage(
                              img: "timer 4.png"),
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
                              text: "₹ ${data![index].price
                                  .toString()}",
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold,
                              fontsize: 15),
                          SizedBox(
                            width: 10,
                          ),
                          UiHelper.CustomButton(() {
                            cartController.addItem(
                                categroy[index]["id"]
                                    .toString(),
                                categroy[index]["text"]
                                    .toString(),
                                categroy[index]["img"]
                                    .toString(),
                                double.parse(
                                    categroy[index]["price"]
                                        .toString()));
                            InteractiveToast.pop(context,
                                title: Text("${categroy[index]["text"]
                                    .toString()} Added"));
                            // Get.snackbar(
                            //     22.toString(),
                            //     "Item added");
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
}
