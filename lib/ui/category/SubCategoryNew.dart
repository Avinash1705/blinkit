import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
import '../cart/cartScreen.dart';
import '../widgets/detailPage.dart';
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

  List<mySubcategory.Data>? data;
  List<allVenders.Data>? allVenderData;

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final responses = await Future.wait([
        subCategoryController.fetchSubCategories(),
        allVenderController.fetchVendors(),
      ]);

      final subCategoryResponse = responses[0] as GetSubCategoryModel;
      final vendorResponse = responses[1] as GetVenderResponseModel;

      setState(() {
        if (widget.data.id!.length == 10) {
          data = subCategoryResponse.data
              ?.where((e) => e.phone == widget.data.id)
              .toList();
        } else {
          data = subCategoryResponse.data
              ?.where((e) => e.categoryId == widget.data.id)
              .toList();
        }

        allVenderData = vendorResponse.data ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load data";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.categoryName.toString()),
        toolbarHeight: 100,
        backgroundColor: const Color(0xfff7Cb45),
      ),

      floatingActionButton: Visibility(
        visible: cartController.getItemCount() != 0,
        child: FloatingActionButton(
          onPressed: () => Get.to(CartScreen()),
          child: Selector<CartController, int>(
            selector: (_, c) => c.getItemCount(),
            builder: (_, count, __) => Text(count.toString()),
          ),
        ),
      ),

      body: Stack(
        children: [
          _buildContent(cartController),

          /// 🔥 BLOCKING LOADER
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(CartController cartController) {
    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (data == null || data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: 60, color: Colors.grey.shade500),
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
      );
    }

    return  GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72, // better height
      ),
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final item = data![index];
        final availableQty = int.tryParse(item.quantity ?? '0') ?? 0;

        return _buildItemCard(item, cartController, availableQty);
      },
    );

  }

  Widget _buildItemCard(
      mySubcategory.Data item,
      CartController cartController,
      int availableQty,
      ) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: availableQty > 0 ? Colors.white : Colors.grey.shade200,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: availableQty > 0 ? () {
          Get.to(DetailPage(item: item));
        } : null,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 IMAGE
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: UiHelper.CustomImageNetworkSubCategory(
                    img: item.itemImg.toString().trim(),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 ITEM NAME
              Text(
                item.itemName.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              // 🔹 PRICE + BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹ ${item.price}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  availableQty > 0
                      ? _AddButton(
                    onTap: () {
                      cartController.addItem(
                        item.id.toString(),
                        item.itemName.toString(),
                        item.itemImg.toString(),
                        double.parse(item.price.toString()),
                        availableQty,
                      );
                      InteractiveToast.pop(
                        title: Text("${item.itemName} added"),
                      );
                    },
                  )
                      : _OutOfStockBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.green),
        ),
        child: const Text(
          "ADD",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
class _OutOfStockBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "Out of stock",
        style: TextStyle(
          color: Colors.red,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


