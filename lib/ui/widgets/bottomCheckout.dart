import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/ui/address/addressScreen.dart';
import 'package:swiggy/ui/orderPlacedScreen.dart';
import '../../controllers/addressController.dart';
import '../../controllers/cartController.dart';
import '../../controllers/checkoutController.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String localAddress = '';
  AddressController addressController = AddressController();

  // void loadPrefs() async {
  //
  //   final prefs = await SharedPreferences.getInstance();
  //  setState(() {
  //    localAddress = prefs.getString('location') ?? "No Address Found";
  //    print("updatedAdd bottom load $localAddress");
  //    print("locAddress ${localAddress}");
  //  });
  //   // try {
  //   //
  //   //
  //   // } catch (e) {
  //   //   localAddress = e.toString();
  //   // }
  // }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
    });
  }

 @override
  void didUpdateWidget(covariant CheckoutScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    // var addressController = Provider.of<AddressController>(context);
    print("addressController updatedAddress: ${addressController.updatedAddress.value}");

    // addressController.saveLocData();
    print("update ");
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
                  Get.to(AddressInputForm(onAddressSaved: (String address) {
                    addressController.saveUserLocationData(address);
                    print("on bottomCheckout $address");
                  },));
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
                  : ElevatedButton(
                      onPressed: () {
                        Get.off(OrderPlacedScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Checkout", style: TextStyle(fontSize: 16)),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
