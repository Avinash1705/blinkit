
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:get_storage/get_storage.dart';

import '../ui/category/searchController.dart';

Future<void> init() async {
  // await GetStorage.init();
  Get.lazyPut(() => SearchController());
  // Get.lazyPut(() => LivePageController());
  // Get.lazyPut(() => LiveStreamingController());
  // Get.lazyPut(() => LoginPageController());
}