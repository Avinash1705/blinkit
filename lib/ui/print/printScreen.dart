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
          children: printController.ordersByDay.entries
              .map((dateEntry) {

            String date = dateEntry.key;
            Map<String, List<Map<String, dynamic>>> ordersMap =
                dateEntry.value;

            return ExpansionTile(
              title: Text(
                "📅 $date",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              /// 🔽 ORDERS INSIDE DATE
              children: ordersMap.entries.map((orderEntry) {

                String orderId = orderEntry.key;
                List<Map<String, dynamic>> items =
                    orderEntry.value;

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ExpansionTile(

                    title: Text(
                      "🧾 Order $orderId",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    children: [

                      /// 🛒 ITEMS
                      ...items.map((order) {

                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: order["item_img"] != null &&
                                order["item_img"]
                                    .toString()
                                    .isNotEmpty
                                ? UiHelper
                                .CustomImageNetworkSubCategory(
                                img: order[
                                "item_img"])
                                : const Icon(
                                Icons.image),
                          ),

                          title: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  order["item_name"] ??
                                      "Item",
                                ),
                              ),
                              Text(
                                "×${order["item_quantity"]}",
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ],
                          ),
                        );

                      }),

                      const Divider(),

                      /// 📍 ADDRESS (once per order)
                      Padding(
                        padding:
                        const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                items.first[
                                "customer_location"] ??
                                    "No address",
                                style:
                                const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
