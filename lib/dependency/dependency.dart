
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ui/category/searchController.dart';

Future<void> init() async {
  Get.lazyPut(() => SearchController());
  // Get.lazyPut(() => LivePageController());
  // Get.lazyPut(() => LiveStreamingController());
  // Get.lazyPut(() => LoginPageController());
}