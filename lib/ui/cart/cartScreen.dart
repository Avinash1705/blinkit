import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../widgets/bottomCheckout.dart';



class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    context.read<AddressController>(); // read only — no rebuild

    final itemsList = cartController.items.values.toList();
    final keysList = cartController.items.keys.toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfff7Cb45),
          centerTitle: true,
          title: UiHelper.CustomText(
            text: "Cart",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 20,
            fontfamily: "bold",
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: Get.back,
          ),
        ),

        /// ✅ NO nested scaffold
        body: Stack(
          children: [

            /// ✅ Single scroll only
            ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 110),
              children: [

                const SizedBox(height: 20),

                if (cartController.itemCount == 0)
                  Center(child: UiHelper.CustomImage(img: "cart.png"))
                else
                  ListView.builder(
                    itemCount: itemsList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final item = itemsList[index];
                      final key = keysList[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: UiHelper.CustomImageNetworkSubCategory(
                            img: item.img,
                          ) ??
                              UiHelper.CustomImage(img: item.img),

                          title: Text(
                            item.title,
                            style: const TextStyle(color: Colors.blue),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: ${item.price}'),
                              Text('Qty: ${item.quantity}'),
                            ],
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// ➖ Remove
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartController.removeItemFromCart(
                                    key,
                                    item.title,
                                    item.img,
                                    item.price,
                                    item.existingQuantity,
                                  );
                                },
                              ),

                              Text('${item.quantity}'),

                              /// ➕ Add
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  if (item.quantity <
                                      int.parse(item.existingQuantity.toString())) {
                                    cartController.addItem(
                                      key,
                                      item.title,
                                      item.img,
                                      item.price,
                                      item.existingQuantity,
                                    );
                                  } else {
                                    InteractiveToast.pop(
                                      title: const Text("Quantity exceeded"),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 20),

                /// ✅ Static content below
                UiHelper.CustomText(
                    text: "Reordering will be easy",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontsize: 16,
                    fontfamily: "bold"),

                UiHelper.CustomText(
                  text:
                  "Items you ordered will be shown here so you can buy again easily",
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontsize: 12,
                ),

                const SizedBox(height: 24),
                _buildBestSellerRow(),
                const SizedBox(height: 40),
              ],
            ),

            /// ✅ Floating checkout (not hiding list)
             Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CheckoutScreen(),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ extracted widget — avoids build clutter
  Widget _buildBestSellerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        UiHelper.CustomImage(img: "milk.png"),
        UiHelper.CustomImage(img: "potato.png"),
        UiHelper.CustomImage(img: "tomato.png"),
      ],
    );
  }
}
