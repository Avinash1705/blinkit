import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';
import 'controllers/printController.dart';
import 'dependency/dependency.dart';

void main() {
  init();

  // runApp(ChangeNotifierProvider(
  //   create: (BuildContext context) {
  //     return CartController()
  //   },
  //   child: MyApp(),
  // ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CartController()),
    ChangeNotifierProvider(create: (a) => AddressController()),
    ChangeNotifierProvider(create: (a) => Printcontroller()),
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blink-it',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNavScreen(index: 0),
    );
  }
}
