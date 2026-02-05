import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/domain/appConsatant.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../../../vender/ui/vender_dashboard.dart';
import '../../bottomNav/bottomNavScreen.dart';
import '../../login/loginScreen.dart';
// import '../venderModels/GetVenderResponseModel.dart' as venderData;
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart' as venderData;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late venderData.Data vendorDetails;
  @override
  void initState() {
    getCustomerId().then((value) {
      print("checking value in init state ${jsonEncode(value)}");
        Get.to(value != null  ?VendorDashboard(vendorDetails: value): BottomNavScreen(index: 0));
      // if (value != null) {
      //   vendorDetails = value ;
      //   print("Customer ID in splash: ${jsonEncode(value)}");
      //   print("Vendor ID in splash: ${vendorDetails.venderId}");
      //   Get.to(value != null  ?VendorDashboard(vendorDetails: vendorDetails): BottomNavScreen(index: 0));
      // }
      // else {
      //   print("Customer ID in splash: ERROR ${value}");
      //   print("Vendor ID in splash: is null");
      //   Get.to(LoginScreen());
      // }
    });
    // Timer(Duration(seconds: 2),() {
    //   Get.to(vendorDetails.venderId![0] == 'v'?VendorDashboard(vendorDetails: vendorDetails): BottomNavScreen(index: 0));
    // });
    super.initState();
  }

  Future<venderData.Data?> getCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppConstant.customer_id =  prefs.getString(AppConstant.customer_id) ?? "";
    String? jsonString = prefs.getString(AppConstant.vendorDetails);

    if (jsonString == null) return null;
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return venderData.Data.fromJson(jsonMap);
    print("Customer ID in splash: ${AppConstant.customer_id}");
  }
  // Get VendorDetails
  // static Future<VendorDetails?> getVendor() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jsonString = prefs.getString(vendorKey);
  //
  //   if (jsonString == null) return null;
  //
  //   Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //   return VendorDetails.fromJson(jsonMap);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "flux.png")
          ],
        ),
      ),
    );
  }
}
