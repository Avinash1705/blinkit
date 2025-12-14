import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/controllers/payementController.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';
// import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../ui/login/loginScreenStatic.dart';
import '../vender/venderModels/GetVenderResponseModel.dart' as venderData;


class PaymentScreen extends StatelessWidget {
  late int payment;
  late int duration;

  //vender detail
  late final venderData.Data vendorDetails;
  PaymentScreen(this.payment,this.duration,this.vendorDetails);
  @override
  Widget build(BuildContext context) {
    print("duration in payment screen $duration");
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Order summary
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                title: Text("Premium Plan"),
                subtitle: Text("Access to all features"),
                trailing: Text("₹$payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red)),
              ),
            ),
            SizedBox(height: 20),

            // Static card info
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Card Number", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("**** **** **** 1234"),

                  SizedBox(height: 16),
                  Text("Card Holder", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("John Doe"),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Expiry", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text("08/26"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CVV", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text("***"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Spacer(),

            // Pay Now button
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Payment Successful"),
                    content: Text("Thank you for your purchase!"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      )
                    ],
                  ),
                );
                Future.delayed(Duration(seconds: 3), () {
                  //duration api update in vender column
                  PaymentController().updateSubscription(vendorDetails.phone!, duration);
                  Get.offAll(() => BottomNavScreen(index: 0));
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Pay ₹$payment", style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
