import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import 'package:swiggy/vender/ui/SubscriptionService.dart';

import '../../ui/login/loginScreen.dart';
import '../../ui/widgets/ImagePickerBoth.dart';
import '../controller/VenderOrdersController.dart';
import '../controller/VenderSpecificProductsController.dart';
import '../controller/addItemsController.dart';
import '../helperWidget/ImagePickerExample.dart';
import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../venderModels/OrderPlacedModel.dart' as orderPlacedModelData;
import '../venderModels/SalesYearDataModel.dart';
import '../venderModels/VenderSpecificProductsModel.dart'
as venderSpecificProductsModelData;
import 'EditAddedProductPage.dart';
import 'categoryDropdown.dart';

class VendorDashboard extends StatelessWidget {
  venderData.Data vendorDetails;

  VendorDashboard({super.key, required this.vendorDetails});

  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40),
  ];
  List<PieData> piedata = [
    PieData('Sales Person 1', 35, 'Person 1'),
    PieData('Sales Person 2', 21, 'Person 2'),
    PieData('Sales Person 3', 32, 'Person 3'),
    PieData('Sales Person 4', 76, 'Person 4'),
    PieData('Sales Person 5', 534, 'Person 5'),
  ];

  @override
  Widget build(BuildContext context) {
    print("${vendorDetails.venderId} Dashboard ${jsonEncode(vendorDetails)}");
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${vendorDetails.venderName} Dashboard ${vendorDetails.valid}'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Vendor Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text('Add Product'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddProductPage(vendorDetail: vendorDetails),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text('My Products'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              MyProductsPage(
                                phone: vendorDetails.phone.toString(),
                              )));
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Orders'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VenderOrdersPage(
                                tableName: ApiConstants.orderTableFormat(
                                    vendorDetails.phone.toString())),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Implement logout
                  Get.off(LoginScreen());
                },
              ),
            ],
          ),
        ),
        body: int.parse(vendorDetails.valid.toString()) == 0
            ? SubscriptionScreen(vendorDetails)
            : Center(
              child: SingleChildScrollView(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Vendor Image
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: UiHelper.CustomImageNetworkShop(
                            img: (vendorDetails.shop_img != null &&
                                vendorDetails.shop_img!.isNotEmpty)
                                ? vendorDetails.shop_img!
                                : "https://via.placeholder.com/300x300.png?text=Shop",
                          ),
                        ),
                      ),
                      //

                      const SizedBox(height: 12),

                      // Vendor Name
                      Text(
                        vendorDetails.venderName ?? "Vendor",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Active Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: int.parse(vendorDetails.valid ?? "0") == 1
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 6),
                          Text(
                           int.parse( vendorDetails.valid ?? "0") == 1 ? "Active" : "Inactive",
                            style: TextStyle(
                              color: int.parse( vendorDetails.valid ?? "0") == 1
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 30),

                      _infoRow(Icons.phone, vendorDetails.phone),
                      _infoRow(Icons.numbers, vendorDetails.venderId),
                      _infoRow(Icons.location_on, vendorDetails.location),
                      _infoRow(Icons.store, vendorDetails.shopName),
                    ],
                  ),
                ),
              )
                      ),
            ));
  }
}

Widget _infoRow(IconData icon, String? value) {
  if (value == null || value.isEmpty) return const SizedBox();

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}

// Placeholder Pages

class AddProductPage extends StatefulWidget {
  venderData.Data vendorDetail;

  AddProductPage({super.key, required this.vendorDetail});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ImagepickerBoth(widget.vendorDetail),
          )),
    );
  }
}

class MyProductsPage extends StatefulWidget {
  String phone;

  MyProductsPage({super.key, required this.phone});

  @override
  State<MyProductsPage> createState() => _MyProductsPage();
}

class _MyProductsPage extends State<MyProductsPage> {
  List<venderSpecificProductsModelData.Data> venderSpecificProductsModelList =
  [];

  @override
  void initState() {
    print("Fetching vendor categories");
    getVendorCategories(widget.phone)
        .then((value) =>
    {
      setState(() {
        // print("check1 ${widget.phone}");
        // print("check2 ${value}");
        venderSpecificProductsModelList = value.data!;
        print(
            "Fetched vendor categories: ${jsonEncode(
                venderSpecificProductsModelList)}");
      })
    })
        .catchError((error) {
      Get.snackbar("Error", "Failed to fetch vendor products: $error");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("My product");
    // You would fetch and display vendor products here
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: venderSpecificProductsModelList.isEmpty
          ? SizedBox(
        child: Center(
          child: Text("No products found \n  for this vendor",
              style: TextStyle(fontSize: 20, color: Colors.red)),
        ),
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          print(
              "new Sdata ${jsonEncode(venderSpecificProductsModelList)}");
          final product = venderSpecificProductsModelList[index];
          return Card(
            child: ListTile(
              // leading: Image.network(product.itemImg ?? '',
              //     width: 50, height: 50, fit: BoxFit.cover),
              leading: UiHelper.CustomImageNetworkSubCategory(
                  img: product.itemImg.toString()),
              title: Text(product.itemName ?? 'No Name'),
              subtitle: RichText(
                text: TextSpan(
                  style:
                  const TextStyle(color: Colors.black, fontSize: 16),
                  // default style
                  children: [
                    const TextSpan(text: 'Price: '),
                    TextSpan(
                      text: '${product.price ?? 'N/A'}\n',
                      style: const TextStyle(
                          color: Colors.green), // ✅ value color
                    ),
                    const TextSpan(text: 'Description: '),
                    TextSpan(
                      text:
                      '${product.itemDescription ?? 'No Description'}\n',
                      style: const TextStyle(
                          color: Colors.blue), // ✅ value color
                    ),
                    const TextSpan(text: 'Weight: '),
                    TextSpan(
                      text: '${product.weight ?? 'Weight'} \n',
                      style: const TextStyle(
                          color: Colors.red), // ✅ value color
                    ),
                    const TextSpan(text: 'Quantity: '),
                    TextSpan(
                      text: '${product.quantity ?? '0'}\n',
                      style: const TextStyle(
                          color: Colors.purple), // ✅ value color
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Implement delete logic here
                  Get.to(EditProductPage(
                    product: product,
                  ));
                  Get.snackbar("Delete",
                      "Delete functionality not implemented yet");
                },
              ),
            ),
          );
        },
        itemCount: venderSpecificProductsModelList.length,
      ),
    );
  }
}

class VenderOrdersPage extends StatefulWidget {
  final String tableName;

  VenderOrdersPage({super.key, required this.tableName});

  @override
  State<VenderOrdersPage> createState() => _VenderOrdersPageState();
}

class _VenderOrdersPageState extends State<VenderOrdersPage> {
  List<orderPlacedModelData.Data> orderPlacedModelList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    VenderOrdersController().fetchOrders(widget.tableName).then((value) {
      if (!mounted) return;
      setState(() {
        orderPlacedModelList = value?.data ?? [];
        isLoading = false;
      });
    }).catchError((error) {
      if (!mounted) return;
      setState(() => isLoading = false);
      Get.snackbar("Error", "Failed to fetch orders: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("orderPlacedModelList ${jsonEncode(orderPlacedModelList)}");
    return Scaffold(
      appBar: AppBar(title: Text("Order Sold")),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : orderPlacedModelList == null || orderPlacedModelList!.isEmpty
          ? const Center(
        child: Text(
          "No orders found",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      )
          : ListView.builder(
        itemCount: orderPlacedModelList!.length,
        itemBuilder: (context, index) {
          final product = orderPlacedModelList![index];

          return Card(
            margin: const EdgeInsets.all(20),
            color: Colors.greenAccent,
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: UiHelper.CustomImageNetworkSubCategory(
                  img: product.itemImg.toString(),
                ),
              ),
              title: Text(product.itemName ?? 'No Name'),
              subtitle: Text(
                'Price: ${product.price ?? 'N/A'}\n'
                    'Description: ${product.itemDescription ??
                    'No Description'}\n'
                    'New Price: ${product.newPrice ?? 'N/A'}\n'
                    'Quantity: ${product.quantity ?? '0'}\n'
                    'Weight: ${product.weight ?? 'N/A'}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Get.snackbar(
                    "Delete",
                    "Delete functionality not implemented yet",
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
