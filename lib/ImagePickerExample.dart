import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swiggy/domain/ApiConstants.dart';

class ImagePickerWithPermission extends StatefulWidget {
  @override
  _ImagePickerWithPermissionState createState() => _ImagePickerWithPermissionState();
}

class _ImagePickerWithPermissionState extends State<ImagePickerWithPermission> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  ImagePickerController imagePickerController = ImagePickerController();
  TextEditingController nameController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(title: Text('Image Picker with Android 13 Support')),
      body: Center(
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
            ElevatedButton(onPressed: () {
              imagePickerController.updateAppDetail(nameController.text.toString(), _image!).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('App detail updated successfully')),
                );
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating app detail: $error')),
                );
              });
            }, child: Text("Update App Detail")),
          ],
        ),
      ),
    );
  }
}

class ImagePickerController {



  Future<String?> updateAppDetail(String name ,File imageFile) async {
    // String url = "http://192.168.1.24/fluxkart/apis/updateAppDetail.php?app_id=$appId";
    String url = "https://royalblue-opossum-328842.hostingersite.com/fluxKart/apis/updateAppDetail.php";

    try {

      var request = await http.MultipartRequest('POST', Uri.parse(url));
      // Add text field
      // request.fields['name'] = name;
      request.fields['name'] = name;
      // Add file field
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',              // must match $_FILES['image'] in PHP
          imageFile.path,
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {

        print("App details updated successfully: ${response.body}");
      } else {
        print("Failed to update app details: ${response.statusCode}");
      }
    return response.body;
    } catch (e) {
      return e.toString();
      print("Error updating app details: $e");
    }
  }
}
