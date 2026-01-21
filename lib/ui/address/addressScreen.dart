import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../bottomNav/bottomNavScreen.dart';
import '../widgets/locationWidget.dart';

class AddressInputForm extends StatefulWidget {
  final Function(String address) onAddressSaved;

   AddressInputForm({super.key,required this.onAddressSaved});

  @override
  State<AddressInputForm> createState() => _AddressInputFormState();
}

class _AddressInputFormState extends State<AddressInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _pincode = TextEditingController();
  final _locationController = TextEditingController();

  var address = "intial save";


  Widget _buildField(
    String label,
    IconData icon,
    TextEditingController controller,
    TextInputType inputType,
    String? Function(String?) validator,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal),
          hintText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // var addressController = Provider.of<AddressController>(context);
    var addressController = Get.find<AddressController>();
    final prefs =  SharedPreferences.getInstance();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.off(BottomNavScreen(
                  index: 3,
                )),
            child: Icon(Icons.arrow_back)),
        title: UiHelper.CustomText(
            text: "Address",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 20,
            fontfamily: "bold"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.3)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocationWidget(locationController: _locationController,nearColor: Colors.black),
            SizedBox(height: 30,),

            ElevatedButton.icon(
              onPressed: () async{
              await addressController.saveUserLocationData(_locationController.text);

                InteractiveToast.slide(context,
                    title: Text("Updated"),
                    toastSetting: SlidingToastSetting(
                      toastAlignment: Alignment.bottomCenter,
                    ));
                Future.delayed(Duration(seconds: 1), () {
                  print("updatedAdd address btn ${_locationController.text}");
                  widget.onAddressSaved(_locationController.text.trim());
                  Get.back();
                });
              },
              icon: Icon(Icons.check_circle_outline,color: Colors.white,),
              label: Text("Save Address",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
