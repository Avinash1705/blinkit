import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../vender/ui/categoryDropdown.dart';
import '../../vender/venderModels/GetVenderResponseModel.dart' as venderData;
import '../../vender/controller/addItemsController.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart' as venderData;

class ImagepickerBoth extends StatefulWidget {
  venderData.Data vendorDetail;

  ImagepickerBoth(this.vendorDetail);
  @override
  State<ImagepickerBoth> createState() => _ImagepickerBothState();
}

class _ImagepickerBothState extends State<ImagepickerBoth> {
  AddItemsController imagePickerController = AddItemsController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
 
  //passed values
  String? selectedCategory;
  // TextEditingController uniqueIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController newPriceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  void handleSelection(String value) {
    setState(() {
      selectedCategory = value;
    });
    print("Selected in parent: $value");
  }
  Future<bool> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request().isGranted;
    } else {
      if (Platform.isAndroid) {
        if (await Permission.storage.isGranted ||
            await Permission.photos.isGranted ||
            await Permission.mediaLibrary.isGranted) {
          return true;
        }

        // Android 13+ specific
        if (await Permission.photos.request().isGranted ||
            await Permission.storage.request().isGranted) {
          return true;
        }
      }
      return false;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    bool granted = await _requestPermission(source);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  void dispose() {
    // uniqueIdController.dispose();
    priceController.dispose();
    productNameController.dispose();
    descController.dispose();
    newPriceController.dispose();
    weightController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Vendor Details: ${jsonEncode(widget.vendorDetail)}");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*product id  == category id */
          CategoryDropdown(onSelected: handleSelection),
          // This will be replaced with the actual category dropdown widget
          // TextField(controller: uniqueIdController,keyboardType: TextInputType.number,inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly, // only allows 0-9
          // ],decoration: InputDecoration(labelText: 'Unique id')),
          // TextField(
          //     controller: productNameController,
          //     decoration: InputDecoration(labelText: 'Product Name')),
          TextField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),inputFormatters: [
              FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d{0,2}'),) // only allows 0-9
          ],
              decoration: InputDecoration(labelText: 'Price')),
          TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description')),
          // TextField(
          //     controller: newPriceController,
          //     decoration: InputDecoration(labelText: 'New Price')),
          TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d{0,2}'),) // only allows 0-9
          ],
              decoration: InputDecoration(labelText: 'Weight')),
          TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // only allows 0-9
          ],
              decoration: InputDecoration(labelText: 'Quantity')),
          SizedBox(height: 20),
          _image == null
              ? Text('No image selected')
              // : Image.file(_image!, height: 200),
              : Column(
                  children: [
                    Image.file(
                      _image!,
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Text('Image Path: ${_image!.path.split('/').last}'),
                    // Text('Image Path:absoluit  ${_image!.absolute.path}'),
                  ],
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => {
              _pickImage(ImageSource.gallery),
            },
            child: Text('Pick from Gallery'),
          ),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            child: Text('Take a Photo'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                print("Selected CategoryVender: $selectedCategory");
              });
              AddItemsController.addItem(
                      // uniqueIdController.text.toString(),
                  widget.vendorDetail.venderId.toString(),
                      nameController.text.toString(),
                  widget.vendorDetail.phone.toString(),
                      descController.text.toString(),
                      int.parse(priceController.text.toString()),
                      0,
                      weightController.text.toString(),
                      int.parse(quantityController.text.toString()),
                      _image!)
                  .then((value) {
                Get.snackbar("Success", jsonDecode(value)['status'].toString());
                // Navigator.pop(context);
              }).catchError((error) {
                Get.snackbar("Error", "Failed to add product: $error");
              });
            }, // replace with add logic
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
