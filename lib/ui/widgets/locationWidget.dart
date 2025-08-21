
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
   TextEditingController locationController;
   Color nearcolor;
   LocationWidget({super.key,required this.locationController,required this.nearcolor});

  @override
  State<LocationWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationWidget> {
  String? _location;
  String _address = "Fetching location...";

  // ✅ Get location from GPS
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    // Request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission permanently denied.")),
      );
      return;
    }

    // ✅ Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
// ✅ Convert coordinates to address
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    String address =
        "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

    // ✅ Update controller
    setState(() {
      widget.locationController.text = address;

    });
  }
  @override
  Widget build(BuildContext context) {
    print("test color ${widget.nearcolor}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Current Location "),
        SizedBox(height: 30,),
        TextFormField(
          controller: widget.locationController,
          style: TextStyle(color: widget.nearcolor??Colors.white),
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.place, color: Colors.white),
            labelText: "Place ",
            labelStyle: TextStyle(color: widget.nearcolor??Colors.white),
            hintText: "Edit current location",
            hintStyle: TextStyle(color: widget.nearcolor.withOpacity(0.9)??Colors.white70),
            filled: true,
            fillColor: widget.nearcolor.withOpacity(0.2),
            suffixIcon: InkWell(onTap:  _getCurrentLocation,child: const Icon(Icons.place, color: Colors.red)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => value == null || value.isEmpty
              ? "Enter location"
              : null,
        ),
      ],
    );
  }
}
