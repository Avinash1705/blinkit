import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../vender/venderModels/GetVenderResponseModel.dart' as venderData;
import '../../vender/controller/addItemsController.dart';

class ImagepickerBoth extends StatefulWidget {
   String selectedCategory = "";
   String venderId = "";
   String productName = "";
   String phone = "";
   String desc = "";
   int price ;
   int newPrice ;
   String weight = "";
   int quantity ;

   ImagepickerBoth({super.key,this.selectedCategory = "",
     this.venderId = "",
     this.productName = "",
     this.phone = "",
     this.desc = "",
     this.price = 0,
     this.newPrice = 0,
     this.weight = "",
     this.quantity = 0});

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
  late venderData.Data vendorDetail;
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
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            onPressed: () =>{
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
                  selectedCategory.toString(),
                  vendorDetail.venderId.toString(),
                  productNameController.text,
                  vendorDetail.phone.toString(),
                  descController.text,
                  priceController.text.toString().isEmpty
                      ? 0
                      : int.parse(priceController.text),
                  int.parse(newPriceController.text),
                  weightController.text,
                  int.parse(quantityController.text),
                  "textImgUrl")
                  .then((value) {
                Get.snackbar("Success", "Product added successfully");
                Navigator.pop(context);
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
