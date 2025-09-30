import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_charts/material_charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import 'package:swiggy/vender/ui/SubscriptionService.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
  late venderData.Data vendorDetails;

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
    print("dashboardVender ${vendorDetails.venderId} Dashboard ${jsonEncode(vendorDetails)}");
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: UiHelper.CustomImageNetworkShop(
                        img: vendorDetails.shop_img.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '${vendorDetails.venderName} Panel',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                        builder: (_) => MyProductsPage(
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
                          VenderOrdersPage(tableName: ApiConstants.orderTableFormat(vendorDetails.phone.toString())),
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
          : SingleChildScrollView(
              child: Expanded(
              child: Column(children: [
                MaterialChartLine(
                    data: [
                    ChartData(value: 15, label: 'Jan'),
                ChartData(value: 32, label: 'Feb'),
                ChartData(value: 28, label: 'Mar'),
                ChartData(value: 45, label: 'Apr'),
              ],
                  width: 600,
                  height: 400,
                  style: LineChartStyle(
                    lineColor: Colors.blue,
                    pointColor: Colors.red,
                    backgroundColor: Colors.white,
                    gridColor: Colors.grey.withValues(alpha: 0.3),
                    strokeWidth: 3.0,
                    pointRadius: 6.0,
                    useCurvedLines: true,
                    curveIntensity: 0.5,
                    roundedPoints: true,
                    labelStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    animationDuration: Duration(milliseconds: 2000),
                    animationCurve: Curves.easeOutCubic,
                    verticalLineColor: Colors.blue.withOpacity(0.7),
                    verticalLineWidth: 2.0,
                    verticalLineStyle: LineStyle.dashed,
                    showTooltips: true,
                    tooltipStyle: TooltipStyle(
                      backgroundColor: Colors.blueGrey[50]!,
                      borderColor: Colors.blue,
                      textStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                  showPoints: true,
                  showGrid: true,
                  showTooltips: true,
                  padding: EdgeInsets.all(20),
                ),
                // Center(
                //     child:
                //     SfCircularChart(
                //         title: ChartTitle(text: 'Sales by sales person'),
                //         legend: Legend(isVisible: true),
                //         series: <PieSeries<PieData, String>>[
                //       PieSeries<PieData, String>(
                //           explode: true,
                //           explodeIndex: 0,
                //           dataSource: piedata,
                //           xValueMapper: (PieData data, _) => data.xData,
                //           yValueMapper: (PieData data, _) => data.yData,
                //           dataLabelMapper: (PieData data, _) => data.text,
                //           dataLabelSettings:
                //               DataLabelSettings(isVisible: true)),
                //     ])),
                // SfCartesianChart(
                //   primaryXAxis: CategoryAxis(),
                //   // Chart title
                //   title: ChartTitle(text: 'Half yearly sales analysis'),
                //   // Enable legend
                //   legend: Legend(isVisible: true),
                //   // Enable tooltip
                //   tooltipBehavior: TooltipBehavior(enable: true),
                //   series: <CartesianSeries<SalesData, String>>[
                //     LineSeries<SalesData, String>(
                //       dataSource: data,
                //       xValueMapper: (SalesData sales, _) => sales.year,
                //       yValueMapper: (SalesData sales, _) => sales.sales,
                //       name: 'Sales',
                //       // Enable data label
                //       dataLabelSettings: DataLabelSettings(isVisible: true),
                //     ),
                //   ],
                // ),
              ]),
            )),
    );
  }
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
  late List<venderSpecificProductsModelData.Data>
      venderSpecificProductsModelList = [];

  @override
  void initState() {
    print("Fetching vendor categories");
    getVendorCategories(widget.phone)
        .then((value) => {
              setState(() {
                // print("check1 ${widget.phone}");
                // print("check2 ${value}");
                venderSpecificProductsModelList = value.data!;
                print(
                    "Fetched vendor categories: ${jsonEncode(venderSpecificProductsModelList)}");
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
      body: venderSpecificProductsModelList.isEmpty?SizedBox(
        child: Center(
          child: Text("No products found \n  for this vendor",
              style: TextStyle(fontSize: 20, color: Colors.red)),
        ),
      ):ListView.builder(
        itemBuilder: (context, index) {
          print("new Sdata ${jsonEncode(venderSpecificProductsModelList)}");
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
                    style: const TextStyle(color: Colors.black, fontSize: 16), // default style
                    children: [
                      const TextSpan(text: 'Price: '),
                      TextSpan(
                        text: '${product.price ?? 'N/A'}\n',
                        style: const TextStyle(color: Colors.green), // ✅ value color
                      ),
                      const TextSpan(text: 'Description: '),
                      TextSpan(
                        text: '${product.itemDescription ?? 'No Description'}\n',
                        style: const TextStyle(color: Colors.blue), // ✅ value color
                      ),

                      const TextSpan(text: 'Weight: '),
                      TextSpan(
                        text: '${product.weight ?? 'Weight'} \n',
                        style: const TextStyle(color: Colors.red), // ✅ value color
                      ),
                      const TextSpan(text: 'Quantity: '),
                      TextSpan(
                        text: '${product.quantity ?? '0'}\n',
                        style: const TextStyle(color: Colors.purple), // ✅ value color
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
  List<orderPlacedModelData.Data>? orderPlacedModelList = [];

  @override
  void initState() {
    VenderOrdersController().fetchOrders(widget.tableName).then((value) {
      setState(() {
        print("Fetched orders: ${jsonEncode(value.data)}");
        orderPlacedModelList = value.data;
      });
    }).catchError((error) {
      Get.snackbar("Error", "Failed to fetch orders: $error");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("orderPlacedModelList ${jsonEncode(orderPlacedModelList)}");
    return Scaffold(
      body: orderPlacedModelList == null ||
              orderPlacedModelList!.isEmpty
          ? SizedBox(
              child: Center(
                child: Text("No orders found",
                    style: TextStyle(fontSize: 20, color: Colors.red)),
              ),
            )
          : ListView.builder(
              itemCount: orderPlacedModelList!.length,
              itemBuilder: (context, index) {
                if (orderPlacedModelList == null ||
                    orderPlacedModelList!.isEmpty) {
                  return const Center(child: Text("No orders found"));
                }
                final product = orderPlacedModelList![index];
                return Card(
                  margin: EdgeInsets.all(20),
                  color: Colors.greenAccent,
                  child: ListTile(
                    // leading: Image.network(product.itemImg ?? '',
                    //     width: 50, height: 50, fit: BoxFit.cover),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: UiHelper.CustomImageNetworkSubCategory(
                          img: product.itemImg.toString()),
                    ),
                    title: Text(product.itemName ?? 'No Name'),
                    subtitle: Text(
                        'Price: ${product.price ?? 'N/A'}\nDescription: ${product.itemDescription ?? 'No Description'}'
                        ''
                        '\nNew Price: ${product.newPrice ?? 'New Price'}\nQuantity: ${product.quantity ?? '0'}\nWeight: ${product.weight ?? 'Weight'}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Implement delete logic here
                        Get.snackbar("Delete",
                            "Delete functionality not implemented yet");
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
