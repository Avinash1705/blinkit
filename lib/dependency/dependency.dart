
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get_storage/get_storage.dart';

import '../controllers/addressController.dart';
import '../controllers/cartController.dart';
import '../controllers/loginCustomerController.dart';
import '../domain/AppConstant.dart';
import '../ui/category/searchController.dart';

Future<void> init() async {
  // await GetStorage.init();
  // localNotification();

  Get.lazyPut(() => SearchController(), fenix: true);
  Get.lazyPut(() => AddressController(), fenix: true);
  Get.lazyPut(() => CartController(), fenix: true);
  // Get.lazyPut(() => LoginCustomerController());

  // await Firebase.initializeApp();
  // Get.lazyPut(() => LivePageController());
  // Get.lazyPut(() => LiveStreamingController());
  // Get.lazyPut(() => LoginPageController());
  // loadUserData();

}
Future<void> loadUserData(SharedPreferences prefs) async {
   // final prefs = await SharedPreferences.getInstance();
  print("test profie inti  Worked");
  AppConstant.customer_id = prefs.getString('customer_id') ?? '';
  AppConstant.customer_name = prefs.getString('customer_name') ?? '';
  AppConstant.phone = prefs.getString('phone') ?? '';
  AppConstant.location =  prefs.getString('location') ?? '';
  AppConstant.customer_profile = prefs.getString('customer_profile') ?? '';
  print("test profie inti  ${AppConstant.customer_id}");
}


