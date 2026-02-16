import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/printController.dart';
import 'package:swiggy/domain/AppConstant.dart';
import '../widgets/bottomCheckout.dart';
import '../widgets/uihelper.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  bool loggedIn = false;
  @override
  void initState() {
    super.initState();
    _checkLogin();
    Future.microtask(() {
      Provider.of<Printcontroller>(context, listen: false)
          .fetchOrders(AppConstant.customer_name, AppConstant.phone);
    });
  }
  Future<void> _checkLogin() async {
    loggedIn = await isUserLoggedIn();
    if (mounted) setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final printController = Provider.of<Printcontroller>(context);
    print("print login $loggedIn");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7Cb45),
        centerTitle: true,
        elevation: 0,
        title: UiHelper.CustomText(
          text: "Orders by Date",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontsize: 20,
        ),
      ),

      body: SafeArea(
        child: loggedIn ? Builder(
          builder: (_) {

            if (printController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (printController.ordersByDay.isEmpty) {
              return const Center(child: Text("No orders found"));
            }

            final dateEntries =
            printController.ordersByDay.entries.toList();

            /// ✅ Use ListView.builder for performance
            return ListView.builder(
              itemCount: dateEntries.length,
              itemBuilder: (context, dateIndex) {

                final dateEntry = dateEntries[dateIndex];
                final date = dateEntry.key;
                final ordersMap = dateEntry.value;

                return ExpansionTile(
                  initiallyExpanded: false,
                  title: Text(
                    "📅 $date",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  /// 🔽 Orders inside date
                  children: ordersMap.entries.map((orderEntry) {

                    final orderId = orderEntry.key;
                    final items = orderEntry.value;

                    if (items.isEmpty) {
                      return const SizedBox();
                    }

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

                            final img = order["item_img"];
                            final name = order["item_name"] ?? "Item";
                            final qty = order["item_quantity"] ?? "1";

                            return ListTile(
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),

                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: (img != null &&
                                    img.toString().isNotEmpty)
                                    ? UiHelper
                                    .CustomImageNetworkSubCategory(
                                    img: img)
                                    : const Icon(Icons.image),
                              ),

                              title: Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              trailing: Text(
                                "×$qty",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );

                          }).toList(),

                          const Divider(),

                          /// 📍 ADDRESS
                          Padding(
                            padding: const EdgeInsets.all(12),
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
                                    items.first["customer_location"]
                                        ?.toString() ??
                                        "No address",
                                    style: const TextStyle(
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
              },
            );
          },
        ):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long, size: 64, color: Colors.grey),
              SizedBox(height: 12),
              Text(
                "No orders to show",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "Login to view your orders",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
