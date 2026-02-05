import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/appConsatant.dart';
import '../controller/EditAddedProductController.dart';
import '../venderModels/VenderSpecificProductsModel.dart';
import '../venderModels/VenderSpecificProductsModel.dart'
    as venderSpecificProductsModelData;

class EditProductPage extends StatefulWidget {
  venderSpecificProductsModelData.Data product; // Pass your product object here

  EditProductPage({super.key, required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;
  late TextEditingController newPriceController;
  late TextEditingController weightController;
  late TextEditingController quantityController;
  late TextEditingController quantityWeightController;
  final List<String> units = ['kg', 'g', 'liter', 'ml'];

  // String? selectedCategory;
  String selectedUnit = 'kg'; // default value

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing product data
    nameController = TextEditingController(text: widget.product.itemName);
    priceController =
        TextEditingController(text: widget.product.price?.toString() ?? '');
    descController =
        TextEditingController(text: widget.product.itemDescription ?? '');
    newPriceController =
        TextEditingController(text: widget.product.new_price?.toString() ?? '');
    weightController =
        TextEditingController(text: widget.product.weight?.toString() ?? '');
    quantityController =
        TextEditingController(text: widget.product.quantity?.toString() ?? '');
    quantityWeightController = TextEditingController(
        text: widget.product.weightQuantity?.toString() ?? '');
    selectedUnit = widget.product.weightQuantity != null
        ? widget.product.weightQuantity.toString()
        : 'kg';
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    newPriceController.dispose();
    weightController.dispose();
    quantityController.dispose();
    quantityWeightController.dispose();
    super.dispose();
  }

  void saveProduct() {
    // Collect edited values
    final updatedProduct = {
      "id": widget.product.id.toString(),
      "itemName": nameController.text,
      "price": priceController.text,
      "itemDescription": descController.text,
      "weightQuantity": quantityWeightController.text,
      "weight": weightController.text,
      "quantity": quantityController.text,
    };

    updateProduct(updatedProduct).then((response) {
      print("Update response: $response");
      // if (response != null) {
      //
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Product updated successfully!")),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Failed to update product.")),
      //   );
      // }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product updated successfully!")));
    });
    Navigator.pop(context, updatedProduct);
    Navigator.pop(context); // Send back edited product
  }

  @override
  Widget build(BuildContext context) {
    print("Editing product: ${jsonEncode(widget.product.weightQuantity)}");

    return Scaffold(
      backgroundColor: AppColors.backgroundAppColor.withOpacity(0.9),
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveProduct,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            // TextField(
            //   controller: quantityWeightController,
            //   keyboardType: TextInputType.text,
            //   decoration: const InputDecoration(labelText: "Amount unit"),
            // ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedUnit,
                items: units.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedUnit = newValue!;
                    quantityWeightController.text = newValue;
                  });
                },
              ),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 1,
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Weight"),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProduct,
              child: Text("Save", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.blue.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
