import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/domain/AppConstant.dart';
import '../widgets/uihelper.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<Printcontroller>(context, listen: false)
          .fetchOrders(AppConstant.customer_name, AppConstant.phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    final printController = Provider.of<Printcontroller>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfff7Cb45),
          title: UiHelper.CustomText(
            text: "Orders by Date",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontsize: 20,
          ),
          centerTitle: true,
          elevation: 0,
        ),

        body: printController.isLoading
            ? const Center(child: CircularProgressIndicator())

            : printController.ordersByDay.isEmpty
            ? const Center(child: Text("No orders found"))

            : ListView(
          children: printController.ordersByDay.entries.map((entry) {
            String date = entry.key;
            List<Map<String, dynamic>> orders = entry.value;
            print("orderValue $orders");
            return ExpansionTile(
              title: Text(
                "📅 $date",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              children: orders.map((order) {
                return  Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: order["item_img"] != null &&
                            order["item_img"].toString().isNotEmpty
                            ? UiHelper.CustomImageNetworkSubCategory(img: order['item_img'])
                            : const Icon(Icons.image, size: 40),
                      ),
                    ),
                    title: Text(
                      order["item_name"] ?? order["customer_name"] ?? "Unknown",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order["customer_location"] ?? "No address"),
                        const SizedBox(height: 4),
                        Text(
                          "Qty: ${order["item_quantity"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );

              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
