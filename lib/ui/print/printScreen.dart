import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
  late final PrintController printController;

  @override
  void initState() {
    super.initState();

    printController = PrintController();

    /// fetch after first frame (safer)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printController.fetchOrders(
       AppConstant.customer_name,
        AppConstant.phone,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PrintController>.value(
      value: printController,
      child: Consumer<PrintController>(
        builder: (context, controller, _) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfff7Cb45),
                title: const Text(
                  "Orders by Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: _buildBody(controller),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(PrintController controller) {
    /// LOADING
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    /// EMPTY STATE
    if (controller.ordersByDay.isEmpty) {
      return const Center(
        child: Text(
          "No orders found",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    /// DATA
    return ListView(
      padding: const EdgeInsets.only(bottom: 12),
      children: controller.ordersByDay.entries.map((entry) {
        final date = entry.key;
        final orders = entry.value;

        return ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            "📅 $date",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: orders.map((order) {
            return Card(
              margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NAME + QTY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order["customer_name"] ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Qty: ${order["item_quantity"] ?? 0}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// ADDRESS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            order["customer_location"] ?? "No address",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    printController.dispose();
    super.dispose();
  }
}



