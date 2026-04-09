

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiggy/vender/ui/EditAddedProductPage.dart';
import '../venderModels/VenderSpecificProductsModel.dart'
as venderSpecificProductsModelData;
import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../../ui/widgets/AddProduct.dart';
import '../controller/addItemsController.dart';

class QuickAddProduct extends StatefulWidget {
  final venderData.Data vendorDetail;

   QuickAddProduct(this.vendorDetail, {super.key});

  @override
  State<QuickAddProduct> createState() => _QuickAddProductState();
}

class _QuickAddProductState extends State<QuickAddProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  bool isAvailable = true;
  bool isLoading = false;

  Future<void> quickAdd() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar("Error", "Enter name & price");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await AddItemsController.addItem(
        "power bank", // default category
        nameController.text.trim(),
        widget.vendorDetail.phone.toString(),
        "", // desc empty
        int.parse(priceController.text),
        0,
        "1", // default weight
        "kg",
        isAvailable ? 1 : 0,
        await getDefaultImage(), // skip image for now
      );
      final result = jsonDecode(response);
      Get.snackbar("Success",result['status'].toString() );

      nameController.clear();
      priceController.clear();

    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", "Failed to add${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }
  Future<File> getDefaultImage() async {
    final byteData = await rootBundle.load('assets/images/flux.png');
    final file = File('${(await getTemporaryDirectory()).path}/flux.png');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quick Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Price
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Availability Toggle
            SwitchListTile(
              title: const Text("Available"),
              value: isAvailable,
              onChanged: (val) {
                setState(() => isAvailable = val);
              },
            ),

            const SizedBox(height: 20),

            // 🔥 Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : quickAdd,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("⚡ Add Product"),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 Optional: Go to full form
            // TextButton(
            //   onPressed: () {
            //     Get.to(EditProductPage(product: widget.vendorDetail.));
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (_) => AddProduct(widget.vendorDetail),
            //     //   ),
            //     // );
            //   },
            //   child: const Text("Add full details →"),
            // )
          ],
        ),
      ),
    );
  }
}