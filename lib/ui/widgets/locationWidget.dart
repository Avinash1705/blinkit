import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final TextEditingController locationController;
  final Color nearColor;

  const LocationWidget({
    super.key,
    required this.locationController,
    required this.nearColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Shop Location",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: locationController,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(color: nearColor),
          decoration: InputDecoration(
            labelText: "Address",
            hintText: "Enter shop address",
            filled: true,
            fillColor: nearColor.withOpacity(0.15),
            suffixIcon: const Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) =>
          value == null || value.trim().isEmpty
              ? "Enter location"
              : null,
        ),
      ],
    );
  }
}
