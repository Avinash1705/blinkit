import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import '../bottomNav/bottomNavScreen.dart';
import '../widgets/locationWidget.dart';

class AddressInputForm extends StatefulWidget {
  final Function(String address) onAddressSaved;

  const AddressInputForm({
    super.key,
    required this.onAddressSaved,
  });

  @override
  State<AddressInputForm> createState() => _AddressInputFormState();
}

class _AddressInputFormState extends State<AddressInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();

  bool _saving = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (_saving) return;

    final text = _locationController.text.trim();

    if (text.isEmpty) {
      InteractiveToast.slide(
        title: const Text("Please enter address"),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      /// Provider without rebuild listening
      context
          .read<AddressController>()
          .saveUserLocationData(text);

      widget.onAddressSaved(text);

      InteractiveToast.slide(
        title: const Text("Address Updated"),
        toastSetting: const SlidingToastSetting(
          toastAlignment: Alignment.bottomCenter,
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) Get.back();
    } catch (e) {
      InteractiveToast.slide(
        title: const Text("Failed to save address"),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: UiHelper.CustomText(
          text: "Address",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontsize: 20,
          fontfamily: "bold",
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.25),
        ),

        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 📍 Location Widget
              LocationWidget(
                locationController: _locationController,
                nearcolor: Colors.black,
              ),

              const SizedBox(height: 30),

              /// 💾 Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _saveAddress,
                  icon: _saving
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.check_circle_outline),

                  label: Text(
                    _saving ? "Saving..." : "Save Address",
                    style: const TextStyle(color: Colors.white),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
