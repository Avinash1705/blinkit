import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  final TextEditingController locationController;
  final TextEditingController? pincodeController;
  final Color nearcolor;

   LocationWidget({
    super.key,
    required this.locationController,
     this.pincodeController,
    required this.nearcolor,
  });

  @override
  State<LocationWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationWidget> {
  bool _loading = false;

  Future<void> _getCurrentLocation() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      /// 1️⃣ Check service enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showSnack("Please enable location services");
        await Geolocator.openLocationSettings();
        return;
      }

      /// 2️⃣ Permission flow
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showSnack("Location permission denied");
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnack("Permission permanently denied. Open settings.");
        await Geolocator.openAppSettings();
        return;
      }

      /// 3️⃣ Get position with timeout
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).timeout(const Duration(seconds: 12));

      /// 4️⃣ Reverse geocode
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        _showSnack("Unable to fetch address");
        return;
      }

      final p = placemarks.first;
      /*pincode */
      widget.pincodeController?.text = p.postalCode??"226022";
      final address = [
        p.name,
        p.subLocality,
        p.locality,
        p.administrativeArea,
        p.country
      ].where((e) => e != null && e.isNotEmpty).join(", ");

      if (!mounted) return;

      widget.locationController.text = address;
    }

    on TimeoutException {
      _showSnack("Location request timed out");
    }

    catch (e) {
      _showSnack("Failed to get location");
    }

    finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Current Location"),
        const SizedBox(height: 20),

        TextFormField(
          controller: widget.locationController,
          style: TextStyle(color: widget.nearcolor),

          decoration: InputDecoration(
            labelText: "Place",
            labelStyle: TextStyle(color: widget.nearcolor),

            hintText: "Edit current location",
            hintStyle: TextStyle(
              color: widget.nearcolor.withOpacity(0.8),
            ),

            filled: true,
            fillColor: widget.nearcolor.withOpacity(0.15),

            suffixIcon: _loading
                ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : IconButton(
              icon: const Icon(Icons.my_location, color: Colors.red),
              onPressed: _getCurrentLocation,
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
