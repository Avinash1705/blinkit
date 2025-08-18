
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
   TextEditingController locationController;
   LocationWidget({super.key,required this.locationController});

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
    return Column(
      children: [
        Text("Current Location"),
        TextFormField(
          controller: widget.locationController,
          decoration: InputDecoration(
            hintText: "Enter current location",
            border: const OutlineInputBorder(),
            suffixIcon: InkWell(onTap:  _getCurrentLocation,child: const Icon(Icons.location_on)),
          ),
          validator: (value) => value == null || value.isEmpty
              ? "Enter location"
              : null,
        ),
      ],
    );
  }
}
