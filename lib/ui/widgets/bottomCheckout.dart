import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/pay/RazorpayPaymentScreen.dart';
import 'package:swiggy/ui/address/addressScreen.dart';
import 'package:swiggy/ui/customerProfile/LoginCustomerProfileScreen.dart';
import 'package:swiggy/ui/login/roleBasedLogin/PhoneNumberPage.dart';
import 'package:swiggy/ui/orderPlacedScreen.dart';
import '../../controllers/addressController.dart';
import '../../controllers/cartController.dart';
import '../../controllers/checkoutController.dart';
import '../../dependency/dependency.dart';
import '../../testMyCode/OtpFrontendMsg91.dart';
import '../../testMyCode/OtpMsg91.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String localAddress = '';
  AddressController addressController = AddressController();
  bool loggedIn = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loggedIn = await isUserLoggedIn();
      print("loggedIn: $loggedIn");
      setState(() {}); // Refresh UI after checking login status
    });
  }

  // @override
  // void didUpdateWidget(covariant CheckoutScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    // var addressController = Provider.of<AddressController>(context);
    print(
        "addressController updatedAddress: ${addressController.updatedAddress.value}");
    // default selected
    // addressController.saveLocData();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Obx(() => Text(addressController.updatedAddress.value,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 1,
                    softWrap: true,
                    style: TextStyle(fontSize: 14, color: Colors.grey))),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Total", style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text("${cartController.totalAmount}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(AddressInputForm(
                    onAddressSaved: (String address) {
                      addressController.saveUserLocationData(address);
                      print("on bottomCheckout $address");
                    },
                  ));
                },
                child: Text("change",
                    style: TextStyle(fontSize: 14, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              cartController.itemCount == 0
                  ? ElevatedButton(
                      onPressed: () {
                        // Get.off(OrderPlacedScreen());
                        InteractiveToast.popError(context,
                            title: Text("Please Add Items"),
                            toastSetting: PopupToastSetting(
                                toastAlignment: Alignment.center,
                                displayDuration: Duration(seconds: 1)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Checkout", style: TextStyle(fontSize: 16)),
                    )
                  : loggedIn
                      ? ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String _selectedPayment =
                                    "online"; // local state for dialog

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text("Confirm Order"),
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 24), // reduce width
                                      content: SizedBox(
                                        height: 170,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Are you sure you want to place this order?",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // Radio buttons
                                            RadioListTile<String>(
                                              title:
                                                  const Text("Online Payment"),
                                              value: "online",
                                              groupValue: _selectedPayment,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedPayment = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile<String>(
                                              title: const Text(
                                                  "Cash on Delivery"),
                                              value: "cod",
                                              groupValue: _selectedPayment,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedPayment = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions:   [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            print("Selected Payment: $_selectedPayment");
                                            if(_selectedPayment == "online"){
                                              // Navigate to Razorpay payment screen
                                              Get.off(RazorpayPaymentScreen(cartController.totalAmount));
                                              // Get.off(CashfreePaymentPage());
                                            } else {
                                              // Handle Cash on Delivery order placement
                                              Get.off(OrderPlacedScreen());
                                            }
                                            // Navigator.of(context).pop();
                                            // Get.off(OrderPlacedScreen()); // Navigate
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Checkout",
                              style: TextStyle(fontSize: 16)),
                        )
                      : ElevatedButton(
                          onPressed: () =>
                              Get.off(PhoneMsg91UI()),
                          child: Text("Login to buy")),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  loadUserData(prefs); // Your existing function
  return prefs.containsKey('customer_id');
}
