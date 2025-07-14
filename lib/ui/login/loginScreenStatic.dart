
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:swiggy/admin/ui/admin_dashboard.dart';
import 'package:swiggy/vender/controller/AllVenderController.dart';
import 'package:swiggy/vender/ui/vender_dashboard.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart';

import '../../vender/ui/vendor_registration.dart';

class StaticLoginScreen extends StatefulWidget {
  const StaticLoginScreen({super.key});

  @override
  State<StaticLoginScreen> createState() => _StaticLoginScreenState();
}

class _StaticLoginScreenState extends State<StaticLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late GetVenderResponseModel getVenderResponseModel ;
  bool otpSent = false;

  @override
  void initState() {
    AllVenderController().fetchVendors().then((value) => {
      getVenderResponseModel = value,
      print("Vendors fetched: ${getVenderResponseModel.data?.length}"),
      setState(() {
        // This will trigger a rebuild with the fetched data
      })
    });
    super.initState();
  }
  void simulateSendOtp() {
    setState(() {
      otpSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP sent (simulated)")),
    );
  }

  void simulateLogin() {
    if (otpController.text == "12345") {
      checkLoginAccess();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(" Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      prefixText: "+91 ",
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (otpSent)
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter OTP",
                      ),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: otpSent ? simulateLogin : simulateSendOtp,
                    child: Text(otpSent ? "Verify OTP" : "Send OTP"),
                  ),
                  // ElevatedButton(onPressed: (){
                  //
                  // }, child: Text("Login as Guest ${getVenderResponseModel.data!.length}")),
                ],
              ),
            ),
            ElevatedButton(onPressed: (){
              Get.to(VendorRegistrationPage());
            }, child: Text("Register")),
          ],
        ),
      ),
    );
  }
  void checkLoginAccess(){
    if(phoneController.value.text == "9999999999"){
      Get.to(AdminDashboard());
    }
    else {
      // if(getVenderResponseModel.data == null || getVenderResponseModel.data!.isEmpty){
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("No vendors found")),
      //   );
      //   return;
      // }
      for(int i=0;i<getVenderResponseModel.data!.length;i++){
        print("no are ${getVenderResponseModel.data?[i].phone}");
        if(getVenderResponseModel.data?[i].phone == phoneController.value.text){
          Get.to(VendorDashboard(
            vendorDetails: getVenderResponseModel.data![i],
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login successful")),
          );
          return;
        }
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Phone Not Registered")),
    );
  }
}


