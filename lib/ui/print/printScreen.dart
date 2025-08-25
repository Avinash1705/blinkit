import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/domain/AppConstant.dart';
import '../../controllers/getAllCustomerOrder.dart';
import '../../controllers/printController.dart';
import '../widgets/uihelper.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {

  final Printcontroller printController = Get.put(Printcontroller());
  @override
  void initState() {
    super.initState();
    printController.fetchOrders(AppConstant.customer_name,AppConstant.phone); // fetch orders grouped by date
  }

  @override
  Widget build(BuildContext context) {
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
        body: Obx(() {
          if (printController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (printController.ordersByDay.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          return ListView(
            children: printController.ordersByDay.entries.map((entry) {
              String date = entry.key;
              List<Map<String, dynamic>> orders = entry.value;

              return ExpansionTile(
                title: Text(
                  "📅 $date",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                children: orders.map((order) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Item Image (Smaller size)
                          if (order["item_img"] != null &&
                              order["item_img"].toString().isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://avitechly.com/fluxKart/img/subCategory/${order["item_img"]}",
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 24),
                                ),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.grey[200],
                                    alignment: Alignment.center,
                                    child: const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                },
                              ),
                            ),

                          const SizedBox(width: 12),

                          // Details Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Customer Name and Quantity
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        order["customer_name"] ?? "Unknown",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "Qty: ${order["item_quantity"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                // Address
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.redAccent, size: 16),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        order["customer_location"] ?? "No address",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );

        }),
      ),
    );
  }
}
