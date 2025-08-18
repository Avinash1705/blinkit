import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/EditAddedProductController.dart';

class EditProductPage extends StatefulWidget {
  final dynamic product; // Pass your product object here

  const EditProductPage({super.key, required this.product});

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

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing product data
    nameController = TextEditingController(text: widget.product.itemName);
    priceController =
        TextEditingController(text: widget.product.price?.toString() ?? '');
    descController =
        TextEditingController(text: widget.product.itemDescription ?? '');
    newPriceController = TextEditingController(
        text: widget.product.new_price?.toString() ?? '');
    weightController =
        TextEditingController(text: widget.product.weight?.toString() ?? '');
    quantityController = TextEditingController(
        text: widget.product.quantity?.toString() ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    newPriceController.dispose();
    weightController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void saveProduct() {
    // Collect edited values
    final updatedProduct = {
      "id": widget.product.id.toString(),
      "itemName": nameController.text,
      "price": priceController.text,
      "itemDescription": descController.text,
      // "newPrice": newPriceController.text,
      "weight": weightController.text,
      "quantity": quantityController.text,
    };

        updateProduct(updatedProduct)
        .then((response) {
      if (response != null) {
        print("Product updated successfully: $response");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product updated successfully!")),
        );
      } else {
        print("Product updated successfully: $response");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update product.")),
        );
      }
    });
    Navigator.pop(context, updatedProduct); // Send back edited product
  }

  @override
  Widget build(BuildContext context) {
    print("Editing product: ${jsonEncode(widget.product)}");
    return Scaffold(
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
            //   controller: newPriceController,
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(labelText: "New Price"),
            // ),
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
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
