import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';

import '../bottomNav/bottomNavScreen.dart';

class AddressInputForm extends StatefulWidget {
  final Function(String address) onAddressSaved;

  const AddressInputForm({super.key, required this.onAddressSaved});

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

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("This is a Custom Toast"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    var addressController = Provider.of<AddressController>(context);
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
      body: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Delivery Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
                const SizedBox(height: 12),
                _buildField(
                    "Full Name",
                    Icons.person,
                    _name,
                    TextInputType.text,
                    (val) => val!.isEmpty ? "Enter your name" : null),
                _buildField(
                    "Phone Number",
                    Icons.phone,
                    _phone,
                    TextInputType.phone,
                    (val) => val!.length < 10 ? "Enter valid number" : null),
                _buildField(
                    "Street Address",
                    Icons.home,
                    _street,
                    TextInputType.streetAddress,
                    (val) => val!.isEmpty ? "Enter street/area" : null),
                _buildField(
                    "City",
                    Icons.location_city,
                    _city,
                    TextInputType.text,
                    (val) => val!.isEmpty ? "Enter city" : null),
                _buildField(
                    "Pincode",
                    Icons.pin_drop,
                    _pincode,
                    TextInputType.number,
                    (val) => val!.length != 6 ? "Enter 6-digit pin" : null),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {

                    address =
                        "${_street.text} - ${_city.text} - ${_pincode.text} ";
                    if (address.isEmpty) address = "Update Address";

                    // addressController.saveAddress(address);
                    addressController.saveLocalAddress(address);
                    // addressController.saveLocalAddress(address);
                    InteractiveToast.slide(context,
                        title: Text("Updated"),
                        toastSetting: SlidingToastSetting(
                          toastAlignment: Alignment.bottomCenter,
                        ));
                    Future.delayed(Duration(seconds: 1), () {
                      Get.back();
                    });
                  },
                  icon: Icon(Icons.check_circle_outline),
                  label: Text("Save Address"),
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
        ),
      ),
    );
  }
}
