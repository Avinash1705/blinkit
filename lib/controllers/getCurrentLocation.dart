// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// Future<void> _getCurrentLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Location services are disabled.")),
//     );
//     return;
//   }
//
//   // Request permission
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location permission denied.")),
//       );
//       return;
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Location permission permanently denied.")),
//     );
//     return;
//   }
//
//   // ✅ Get current position
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
// // ✅ Convert coordinates to address
//   List<Placemark> placemarks =
//   await placemarkFromCoordinates(position.latitude, position.longitude);
//
//   Placemark place = placemarks[0];
//   String address =
//       "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//
//   // ✅ Update controller
//   setState(() {
//     widget.locationController.text = address;
//
//   });
// }