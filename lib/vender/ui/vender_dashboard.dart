import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ui/login/loginScreen.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
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
                  builder: (_) => const AddProductPage(),
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

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: 'Product Name')),
            TextField(decoration: InputDecoration(labelText: 'Price')),
            TextField(decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: null, // replace with add logic
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You would fetch and display vendor products here
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: const Center(child: Text("List of Vendor's Products")),
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
      body: const Center(child: Text("List of Orders on Vendor's Products")),
    );
  }
}
