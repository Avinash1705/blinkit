import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../controllers/categoriesController.dart';
import '../../model/GetCategoriesResponseModel.dart';
import '../../ui/login/loginScreen.dart';
import '../controller/VenderSpecificProductsController.dart';
import '../controller/addItemsController.dart';
import '../venderModels/GetVenderResponseModel.dart' as venderData;
import '../venderModels/VenderSpecificProductsModel.dart' as venderSpecificProductsModelData;
import 'categoryDropdown.dart';

class VendorDashboard extends StatelessWidget {
  final venderData.Data vendorDetails;
   VendorDashboard({super.key,  required this.vendorDetails});

  @override
  Widget build(BuildContext context) {
    print("${vendorDetails.venderId} Dashboard");
    return Scaffold(
      appBar: AppBar(
        title:  Text('${vendorDetails.venderName} Dashboard'),
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) =>  AddProductPage(vendorDetail: vendorDetails),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('My Products'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const MyProductsPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Orders'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const VendorOrdersPage(),
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
      body: const Center(
        child: Text(
          'Welcome, Vendor!',
          style: TextStyle(fontSize: 24),
        ),
      ),
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:  [
            /*need to show product id from category api*/
            TextField(decoration: InputDecoration(labelText: 'Unique id')),
            /*product id  == category id */
            CategoryDropdown(onSelected: handleSelection), // This will be replaced with the actual category dropdown widget
            // TextField(controller: uniqueIdController,decoration: InputDecoration(labelText: 'Product Id')),
            TextField(controller: productNameController,decoration: InputDecoration(labelText: 'Product Name')),
            TextField(controller: priceController,decoration: InputDecoration(labelText: 'Price')),
            TextField(controller: descController,decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                  setState(() {
                    print("Selected CategoryVender: $selectedCategory");
                  });
                AddItemsController.addItem(selectedCategory.toString(),widget.vendorDetail.venderId.toString(), productNameController.text,
                                        widget.vendorDetail.phone.toString(), descController.text, priceController.text.toString().isEmpty ? 0 :
                                        int.parse(priceController.text))
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
      ),
    );
  }


}

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPage();
}
class _MyProductsPage extends State<MyProductsPage> {
  late List<venderSpecificProductsModelData.Data> venderSpecificProductsModelList = [];
  @override
  void initState() {
    print("Fetching vendor categories");
    getVendorCategories().then((value) => {
      setState(() {
        venderSpecificProductsModelList = value.data!;
        print("Fetched vendor categories: ${venderSpecificProductsModelList.length}");
      })
    }).catchError((error) {
      Get.snackbar("Error", "Failed to fetch vendor products: $error");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // You would fetch and display vendor products here
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: ListView.builder(itemBuilder: (context, index) {
        final product = venderSpecificProductsModelList[index];
        return Card(
          child: ListTile(
            leading: Image.network(product.itemImg ?? '', width: 50, height: 50, fit: BoxFit.cover),
            title: Text(product.itemName ?? 'No Name'),
            subtitle: Text('Price: ${product.price ?? 'N/A'}\nDescription: ${product.itemDescription ?? 'No Description'}'
                ''
                  '\nNew Price: ${product.new_price ?? 'New Price'}\nQuantity: ${product.quantity ?? '0'}\nWeight: ${product.weight ?? 'Weight'}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Implement delete logic here
                Get.snackbar("Delete", "Delete functionality not implemented yet");
              },
            ),
          ),
        );
      }, itemCount: venderSpecificProductsModelList.length,),
    );
  }


}

class VendorOrdersPage extends StatelessWidget {
  const VendorOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Show orders placed on vendor's products
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body:  Center(child: Text("List of Orders on Vendor's Products")),
    );
  }
}
