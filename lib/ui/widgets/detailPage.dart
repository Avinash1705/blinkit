import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import '../../controllers/cartController.dart';
import '../../model/GetSubCategoryModel.dart' as mySubcategory;
import '../cart/cartScreen.dart';

class DetailPage extends StatelessWidget {
  final mySubcategory.Data item;

  const DetailPage({super.key, required this.item});

  Widget infoRow(String label, String? value) {
    if (value == null || value.isEmpty) return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartController =
    Provider.of<CartController>(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: cartController.getItemCount() != 0 ,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(CartScreen());
          },
          child: Selector<CartController, int>(
            selector: (context, cartController) =>
                cartController.getItemCount(),
            builder: (context, itemCount, child) {
              return Text(itemCount.toString());
            },
          ),
        ),
      ),
      body: Stack(
        children: [

          /// 🔥 Scroll Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ✅ HERO IMAGE HEADER
                Stack(
                  children: [
                    Hero(
                      tag: item.id.toString(),
                      child: SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: UiHelper.CustomImageNetworkSubCategory(
                          img: item.itemImg.toString(),
                        ),
                      ),
                    ),

                    /// Back button overlay
                    Positioned(
                      top: 40,
                      left: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),

                /// 🔥 INFO CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// NAME
                      Text(
                        item.itemName ?? "",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// PRICE + WEIGHT ROW
                      Row(
                        children: [
                          Text(
                            "₹ ${item.price ?? item.price ?? "0"}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 10),

                          if (item.new_price != null && item.price != null)
                            Text(
                              "₹ ${item.new_price}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),

                          const Spacer(),

                          if ((item.weightQuantity ?? "").isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(item.weightQuantity!),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// STOCK BADGE
                      if (item.quantity == "0")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Out of Stock",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      const SizedBox(height: 18),

                      /// DESCRIPTION
                      if ((item.itemDescription ?? "").isNotEmpty) ...[
                        const Text(
                          "About this item",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.itemDescription!,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      /// DETAILS SECTION
                      const Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      infoRow("Category ID", item.categoryId),
                      infoRow("Product ID", item.id),
                      infoRow("Weight", item.weight),
                      infoRow("Quantity", item.quantity),
                      infoRow("Phone", item.phone),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 STICKY ADD TO CART BAR
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.08),
                  )
                ],
              ),
              child: InkWell(

                child: SizedBox(
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      item.quantity == "0"
                          ? null:
                      cartController.addItem(
                        item.id.toString(),
                        item.itemName.toString(),
                        item.itemImg.toString(),
                        double.parse(
                            item.price.toString()),
                        int.tryParse(item.quantity
                            .toString()) ??
                            0, // ✅ real stock
                      );
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
