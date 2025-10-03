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

  CustomAppBar(
      {super.key,
      required TextEditingController controller,
      this.allVenderData});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController controller = TextEditingController();
  final _locationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getCurrentLocation(_locationController);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 190,
          width: double.infinity,
          color: Color(0xfff7Cb45),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "FluxKart",
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontsize: 15,
                      fontfamily: "bold")
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  UiHelper.CustomText(
                      text: "15 minutes",
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontsize: 20,
                      fontfamily: "bold")
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                 Flexible(child:  UiHelper.CustomText(
                     text: "HOME-${_locationController.text}",
                     color: Color(0xFF000000),
                     fontWeight: FontWeight.bold,
                     fontsize: 14,
                     fontfamily: "bold")),
                  UiHelper.CustomText(
                      text: AppConstant.location,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontsize: 14,
                      fontfamily: "bold")
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 100,
          child: CircleAvatar(
              radius: 14,
              backgroundImage: AppConstant.customer_profile == null
                  ? AssetImage("assets/images/user.png")
                  : UiHelper.CustomImageNetworkCustomerProfile(
                      img: AppConstant.customer_profile)),
        ),
        Positioned(
            bottom: 30,
            left: 20,
            child: InkWell(
              onTap: () {
                Get.to(CustomSearchAppBar(allVenderData: widget.allVenderData));
              },
              child: IgnorePointer(
                child: UiHelper.CustomTextField(controller: controller),
              ),
            ))
      ],
    );
  }
  Future<void> _getCurrentLocation(locationController) async {
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
      locationController.text = address;
    });
  }
}
