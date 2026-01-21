//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationWidget extends StatefulWidget {
//    TextEditingController locationController;
//    Color nearcolor;
//    LocationWidget({super.key,required this.locationController,required this.nearcolor});
//
//   @override
//   State<LocationWidget> createState() => _LocationState();
// }
//
// class _LocationState extends State<LocationWidget> {
//   String? _location;
//   String _address = "Fetching location...";
//
//   // ✅ Get location from GPS
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location services are disabled.")),
//       );
//       return;
//     }
//
//     // Request permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Location permission denied.")),
//         );
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location permission permanently denied.")),
//       );
//       return;
//     }
//
//     // ✅ Get current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
// // ✅ Convert coordinates to address
//     List<Placemark> placemarks =
//     await placemarkFromCoordinates(position.latitude, position.longitude);
//
//     Placemark place = placemarks[0];
//     String address =
//         "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//
//     // ✅ Update controller
//     setState(() {
//       widget.locationController.text = address;
//
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("test color ${widget.nearcolor}");
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Current Location "),
//         SizedBox(height: 30,),
//         TextFormField(
//           controller: widget.locationController,
//           style: TextStyle(color: widget.nearcolor??Colors.white),
//           decoration: InputDecoration(
//             // prefixIcon: Icon(Icons.place, color: Colors.white),
//             labelText: "Place ",
//             labelStyle: TextStyle(color: widget.nearcolor??Colors.white),
//             hintText: "Edit current location",
//             hintStyle: TextStyle(color: widget.nearcolor.withOpacity(0.9)??Colors.white70),
//             filled: true,
//             fillColor: widget.nearcolor.withOpacity(0.2),
//             suffixIcon: InkWell(onTap:  _getCurrentLocation,child: const Icon(Icons.place, color: Colors.red)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           validator: (value) => value == null || value.isEmpty
//               ? "Enter location"
//               : null,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
   TextEditingController locationController;
   Color nearColor;

   LocationWidget({
    super.key,
    required this.locationController,
    required this.nearColor,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _loading = false;

  // =========================
  // MAIN LOCATION FUNCTION
  // =========================
  Future<void> _getCurrentLocation() async {
    setState(() => _loading = true);

    // 1️⃣ Check location services
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _loading = false);
      _showEnableLocationDialog();
      return;
    }

    // 2️⃣ Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _loading = false);
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _loading = false);
      _showPermissionSettingsDialog();
      return;
    }

    try {
      // 3️⃣ Get current position (foreground only)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 4️⃣ Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      String address =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      setState(() {
        widget.locationController.text = address;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      _showErrorDialog();
    }
  }

  // =========================
  // DIALOGS (GOOGLE APPROVED)
  // =========================

  void _showEnableLocationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enable Location Services"),
        content: const Text(
          "Location services are required to update your current location.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text(
          "Please allow location permission to update your current location.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
          "Location permission is permanently denied. Please enable it from app settings.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: const Text(
          "Unable to fetch location. Please try again.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Location",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: widget.locationController,
          readOnly: false,
          style: TextStyle(color: widget.nearColor),
          decoration: InputDecoration(
            labelText: "Place",
            hintText: "Update current location",
            filled: true,
            fillColor: widget.nearColor.withOpacity(0.15),
            suffixIcon: _loading
                ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : InkWell(
              onTap: _getCurrentLocation,
              child: const Icon(Icons.place, color: Colors.red),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) =>
          value == null || value.isEmpty ? "Enter location" : null,
        ),
      ],
    );
  }
}
