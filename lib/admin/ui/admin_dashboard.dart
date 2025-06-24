import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/ui/login/loginScreen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Admin Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Manage Vendors'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const ManageVendorsPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Manage Products'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const ManageProductsPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('View Orders'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const OrdersPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // implement logout logic
                Get.off(LoginScreen());
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome, Admin!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Placeholder pages

class ManageVendorsPage extends StatelessWidget {
  const ManageVendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Vendors')),
      body: const Center(child: Text('Vendor List & Approval')),
    );
  }
}

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Products')),
      body: const Center(child: Text('Product List')),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Orders')),
      body: const Center(child: Text('Order History')),
    );
  }
}
