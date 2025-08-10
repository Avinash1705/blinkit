// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
// class CameraFullScreen extends StatefulWidget {
//   @override
//   State<CameraFullScreen> createState() => _CameraFullScreenState();
// }
//
// class _CameraFullScreenState extends State<CameraFullScreen> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _takePicture() async {
//     // Request camera permission
//     final status = await Permission.camera.request();
//
//     if (status.isGranted) {
//       final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Camera permission denied")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: _takePicture, // Tap anywhere to take a picture
//         child: Container(
//           color: Colors.black,
//           width: double.infinity,
//           height: double.infinity,
//           child: _image == null
//               ? const Center(
//             child: Text(
//               "Tap to take a picture",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           )
//               : Image.file(
//             _image!,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }