import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../../services/payment.dart';

class SubscriptionScreen extends StatefulWidget {
  late final venderData.Data vendorDetails;

  SubscriptionScreen(this.vendorDetails);
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedPlanIndex = -1;

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Basic',
      'time': '1 month',
      'price': '₹99',
      'features': ['Feature A', 'Feature B']
    },
    {
      'title': 'Premium',
      'time': '12 month',
      'price': '₹199',
      'features': ['All Basic Features', 'Feature C', 'Feature D']
    },
    {
      'title': 'Pro',
      'time': '2 Year',
      'price': '₹299',
      'features': ['All Premium Features', 'Priority Support']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Subscription")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  final isSelected = index == selectedPlanIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                    child: Card(
                      elevation: isSelected ? 8 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(plan['title'],
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(plan['time'],
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(plan['price'], style: TextStyle(fontSize: 16)),
                            ...plan['features'].map<Widget>((f) => Row(
                              children: [
                                Icon(Icons.check, size: 16, color: Colors.green),
                                SizedBox(width: 4),
                                Text(f),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: selectedPlanIndex == -1
                  ? null
                  : () {
                final selected = plans[selectedPlanIndex];
                // Proceed to payment or backend call
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text('Selected: ${selected['title']}'),
                // ));
                print("${amount(selected['price'])} ${duration(selected['time'])} ");
                Get.to(PaymentScreen(amount(selected['price']),duration(selected['time']), widget.vendorDetails));
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                backgroundColor: selectedPlanIndex != -1 ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  int amount(String price){
    int amt = int.parse(price.substring(1,price.length));
    return amt;
  }
  int duration(String time){
    if(time.contains("month")){
      return int.parse(time.substring(0,time.indexOf(" ")));
    }else if(time.contains("Year")){
      return int.parse(time.substring(0,time.indexOf(" ")))*12;
    }
    else {
      return 0;
    }
  }
}
