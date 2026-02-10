import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
    as allVenders;
import '../../controllers/cartController.dart';
import '../category/filteredListScreen.dart';

class CustomAppBar extends StatefulWidget {
  final List<allVenders.Data>? allVenderData;
  final TextEditingController controller;

  const CustomAppBar({
    super.key,
    required this.controller,
    this.allVenderData,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _locationController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// HEADER
        Container(
          height: 190,
          width: double.infinity,
          color: const Color(0xfff7Cb45),
          child: Column(
            children: [

              const SizedBox(height: 30),

              Row(
                children: const [
                  SizedBox(width: 20),
                  Text("FluxKart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),

              Row(
                children: const [
                  SizedBox(width: 20),
                  Text("15 minutes",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),

              Row(
                children: [
                  const SizedBox(width: 20),

                  Expanded(
                    child: Text(
                      _locationController.text.isEmpty
                          ? "Fetching location..."
                          : "HOME — ${_locationController.text}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        /// PROFILE AVATAR
        Positioned(
          right: 20,
          bottom: 100,
          child: CircleAvatar(
            radius: 14,
            backgroundImage:
            AppConstant.customer_profile == null
                ? const AssetImage(
                "assets/images/user.png")
                : NetworkImage(
              AppConstant.customer_profile!,
            ) as ImageProvider,
          ),
        ),

        /// SEARCH BAR
        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: InkWell(
            onTap: () {
              Get.to(() => CustomSearchAppBar(
                  allVenderData:
                  widget.allVenderData));
            },
            child: IgnorePointer(
              child: UiHelper.CustomTextField(
                  controller: widget.controller),
            ),
          ),
        ),
      ],
    );
  }

  /// ✅ Production-safe location
  Future<void> _getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _snack("Enable location services");
        return;
      }

      var permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
        await Geolocator.requestPermission();
      }

      if (permission ==
          LocationPermission.deniedForever) {
        _snack("Location permission denied");
        return;
      }

      final pos =
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 15),
      );

      final placemarks =
      await placemarkFromCoordinates(
          pos.latitude, pos.longitude);

      if (placemarks.isEmpty) return;

      final p = placemarks.first;

      final address = [
        p.locality,
        p.administrativeArea,
        p.country
      ].whereType<String>().join(", ");

      if (!mounted) return;

      setState(() {
        _locationController.text = address;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Location error: $e");
      }
    }
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}

