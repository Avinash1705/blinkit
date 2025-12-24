import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/vender/ui/vender_dashboard.dart';
import 'package:swiggy/vender/ui/vendor_registration.dart';

import '../../../controllers/loginCustomerController.dart';
import '../../../vender/controller/AllVenderController.dart';
import '../../../vender/venderModels/GetVenderResponseModel.dart';
import '../../customerProfile/RegistrationCustomerProfileScreen.dart';

class RoleSelectionPage extends StatefulWidget {

  String phone;

   RoleSelectionPage(this.phone,{super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {

  String? selectedRole; // customer OR vendor
  late GetVenderResponseModel getVenderResponseModel ;
  late Data vendorDetails;

  @override
  void initState() {

    print("my test222 ${widget.phone}");
      // LoginCustomerController.returnLoginRegisteredCustomer(widget.phone,context).then((value) => {
      //   print("my test222131 ${value}")
      // });
    // if(widget.role == 'c'){
    //   //will also redirect
    //   LoginCustomerController.returnLoginRegisteredCustomer(widget.phone,context).then((value) => {
    //     print("my test22 ${value}")
    //   });
    // }
    // else if(widget.role == 'v') {
    //   AllVenderController().fetchVendors().then((value) => {
    //     getVenderResponseModel = value,
    //     filterRequiredVendor(),
    //     print("Vendors fetched: ${getVenderResponseModel.data?.length}")
    //   });
    // }
    super.initState();
  }
  filterRequiredVendor(){
    for(int i=0;i<getVenderResponseModel.data!.length;i++){
      print("check each step  ${getVenderResponseModel.data?[i].phone} == ${widget.phone}");
      if(getVenderResponseModel.data?[i].phone == widget.phone){
        vendorDetails = getVenderResponseModel.data![i];
        print("this time is vendor ${jsonEncode(vendorDetails)}");
        Get.to(VendorDashboard(
          vendorDetails: getVenderResponseModel.data![i],
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );
        return;
      }
      else {
        Get.to(VendorRegistrationPage());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Continue As"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 30),

            const Text(
              "Choose your role",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Select how you want to use the app.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            // CUSTOMER CARD
            _roleCard(
              icon: Icons.shopping_bag,
              title: "Customer",
              description: "Buy products, order and explore.",
              value: "customer",
            ),

            const SizedBox(height: 20),

            // VENDOR CARD
            _roleCard(
              icon: Icons.storefront,
              title: "Vendor",
              description: "Sell products and manage your shop.",
              value: "vendor",
            ),

            const Spacer(),

            // Continue Button
            ElevatedButton(
              onPressed: selectedRole == null ? null : () {
                print("checkRole $selectedRole");
                if(selectedRole == "vendor"){
                    AllVenderController().fetchVendors().then((value) => {
                      getVenderResponseModel = value,
                      filterRequiredVendor(),
                    });
                }
                else {
                    LoginCustomerController.returnLoginRegisteredCustomer(widget.phone,context).then((value) => {
                      print("my test22 ${value}")
                    });
                }

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "CONTINUE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _roleCard({
    required IconData icon,
    required String title,
    required String description,
    required String value,
  }) {
    bool isSelected = selectedRole == value;

    return InkWell(
      onTap: () {
        setState(() => selectedRole = value);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: isSelected ? Colors.blue : Colors.grey),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.blue : Colors.black,
                      )),
                  const SizedBox(height: 5),
                  Text(description,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.blue, size: 28),
          ],
        ),
      ),
    );
  }
}
