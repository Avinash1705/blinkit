import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import 'package:swiggy/vender/ui/SubscriptionService.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../ui/login/loginScreen.dart';
import '../controller/VenderOrdersController.dart';
import '../controller/VenderSpecificProductsController.dart';
import '../controller/addItemsController.dart';
import '../helperWidget/ImagePickerExample.dart';
import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../venderModels/OrderPlacedModel.dart' as orderPlacedModelData;
import '../venderModels/SalesYearDataModel.dart';
import '../venderModels/VenderSpecificProductsModel.dart'
    as venderSpecificProductsModelData;
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
    print("${vendorDetails.venderId} Dashboard ${vendorDetails.valid}");
    return Scaffold(
        appBar: AppBar(
          title: Text('${vendorDetails.venderName} Dashboard ${vendorDetails.valid}'),
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
                            VenderOrdersPage(tableName: "table8700000000"),
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
        body: vendorDetails.valid! == 0 ?SubscriptionScreen(vendorDetails):SingleChildScrollView(
            child: Expanded(child: Column(children: [
              Center(
                  child:SfCircularChart(
                      title: ChartTitle(text: 'Sales by sales person'),
                      legend: Legend(isVisible: true),
                      series: <PieSeries<PieData, String>>[
                        PieSeries<PieData, String>(
                            explode: true,
                            explodeIndex: 0,
                            dataSource: piedata,
                            xValueMapper: (PieData data, _) => data.xData,
                            yValueMapper: (PieData data, _) => data.yData,
                            dataLabelMapper: (PieData data, _) => data.text,
                            dataLabelSettings: DataLabelSettings(isVisible: true)),
                      ]
                  )
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                    dataSource: data,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
              // SfSparkLineChart.custom(
              //   //Enable the trackball
              //   trackball: SparkChartTrackball(
              //     activationMode: SparkChartActivationMode.tap,
              //   ),
              //   //Enable marker
              //   marker: SparkChartMarker(
              //     displayMode: SparkChartMarkerDisplayMode.all,
              //   ),
              //   //Enable data label
              //   labelDisplayMode: SparkChartLabelDisplayMode.all,
              //   xValueMapper: (int index) => data[index].year,
              //   yValueMapper: (int index) => int.parse(data[index].sales.toString()),
              //   dataCount: 5,
              // ),

            ]),)),
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
  String? selectedCategory;

  void handleSelection(String value) {
    setState(() {
      selectedCategory = value;
    });
    print("Selected in parent: $value");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController uniqueIdController = TextEditingController();
    TextEditingController productNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descController = TextEditingController();
    TextEditingController newPriceController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*need to show product id from category api*/
                TextField(decoration: InputDecoration(labelText: 'Unique id')),
                /*product id  == category id */
                CategoryDropdown(onSelected: handleSelection),
                // This will be replaced with the actual category dropdown widget
                // TextField(controller: uniqueIdController,decoration: InputDecoration(labelText: 'Product Id')),
                TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product Name')),
                TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price')),
                TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: 'Description')),
                TextField(
                    controller: newPriceController,
                    decoration: InputDecoration(labelText: 'New Price')),
                TextField(
                    controller: weightController,
                    decoration: InputDecoration(labelText: 'Weight')),
                TextField(
                    controller: quantityController,
                    decoration: InputDecoration(labelText: 'Quantity')),
                SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  // Get.to(CameraFullScreen());
                  SnackBar(content: Text("Image Picker not implemented yet"));
                }, child: Text("Image Picker")),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      print("Selected CategoryVender: $selectedCategory");
                    });
                    AddItemsController.addItem(
                            selectedCategory.toString(),
                            widget.vendorDetail.venderId.toString(),
                            productNameController.text,
                            widget.vendorDetail.phone.toString(),
                            descController.text,
                            priceController.text.toString().isEmpty
                                ? 0
                                : int.parse(priceController.text),
                            int.parse(newPriceController.text),
                            weightController.text,
                            int.parse(quantityController.text),
                            "textImgUrl")
                        .then((value) {
                      Get.snackbar("Success", "Product added successfully");
                      Navigator.pop(context);
                    }).catchError((error) {
                      Get.snackbar("Error", "Failed to add product: $error");
                    });
                  }, // replace with add logic
                  child: Text("Submit"),
                )
              ],
            ),
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
    // You would fetch and display vendor products here
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          print("new Sdata ${jsonEncode(venderSpecificProductsModelList)}");
          final product = venderSpecificProductsModelList[index];
          return Card(
            child: ListTile(
              // leading: Image.network(product.itemImg ?? '',
              //     width: 50, height: 50, fit: BoxFit.cover),
              leading: UiHelper.CustomImageNetworkSubCategory(img: product.itemImg.toString()),
              title: Text(product.itemName ?? 'No Name'),
              subtitle: Text(
                  'Price: ${product.price ?? 'N/A'}\nDescription: ${product.itemDescription ?? 'No Description'}'
                  ''
                  '\nNew Price: ${product.new_price ?? 'New Price'}\nQuantity: ${product.quantity ?? '0'}\nWeight: ${product.weight ?? 'Weight'}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Implement delete logic here
                  Get.snackbar(
                      "Delete", "Delete functionality not implemented yet");
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
      body:  orderPlacedModelList == null
          ? const CircularProgressIndicator()
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
                leading: SizedBox( width: 50, height: 50,child: UiHelper.CustomImageNetworkSubCategory(img: product.itemImg.toString()),),
                title: Text(product.itemName ?? 'No Name'),
                subtitle: Text(
                    'Price: ${product.price ?? 'N/A'}\nDescription: ${product.itemDescription ?? 'No Description'}'
                        ''
                        '\nNew Price: ${product.newPrice ?? 'New Price'}\nQuantity: ${product.quantity ?? '0'}\nWeight: ${product.weight ?? 'Weight'}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Implement delete logic here
                    Get.snackbar(
                        "Delete", "Delete functionality not implemented yet");
                  },
                ),
              ),
            );
          }),
    );
  }
}
