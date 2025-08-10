// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:swiggy/controllers/addressController.dart';
import 'package:swiggy/controllers/cartController.dart';
import 'package:swiggy/services/payment.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';
import 'package:swiggy/ui/login/loginScreen.dart';
import 'package:swiggy/ui/login/loginScreenStatic.dart';
import 'package:swiggy/ui/screens/splash/splashScreen.dart';
import 'package:swiggy/vender/ui/SubscriptionService.dart';
import 'package:swiggy/vender/ui/vender_dashboard.dart';
import 'package:swiggy/vender/ui/vendor_registration.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart';
import 'controllers/appDetails/appDetails.dart';
import 'controllers/printController.dart';
import 'dependency/dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  init();

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
      title: 'Flux-it',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BottomNavScreen(index: 0),
      // home: SubscriptionScreen(),
      // home: PaymentScreen(),
      home: VendorDashboard(vendorDetails: Data(venderName: "terr",venderId: "12",shopName: "firstShop",phone: "4444444444",location: "lko",valid: "0"),),
      // home: AddProductPage(vendorDetails: Data(venderName: "terr",venderId: "12",shopName: "firstShop",phone: "3223",location: "lko"),),
      // home: MyProductsPage(),
      // home: StaticLoginScreen(),
      // home: SplashScreen(),
      // home: AddProductPage(vendorDetail: null,),
    );
  }
}
