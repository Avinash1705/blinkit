// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../venderModels/LatLng.dart';
//
//
//
// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LatLng {
//   final double lat;
//   final double lng;
//   LatLng(this.lat, this.lng);
// }
//
// class VendorDistanceController extends GetxController {
//
//   /// 📦 cache: vendorKey → "1.2 km"
//   final Map<String, String> distanceCache = {};
//
//   /// 🔁 address → lat/lng
//   Future<LatLng?> getLatLngFromAddress(String address) async {
//     try {
//       final list = await locationFromAddress(address);
//       if (list.isEmpty) return null;
//
//       return LatLng(list.first.latitude, list.first.longitude);
//     } catch (e) {
//       print("Geocode error: $e");
//       return null;
//     }
//   }
//
//   /// 📏 real km distance
//   Future<String?> distanceKm(
//       String customerAddress,
//       String vendorAddress,
//       ) async {
//     final c = await getLatLngFromAddress(customerAddress);
//     final v = await getLatLngFromAddress(vendorAddress);
//
//     if (c == null || v == null) return null;
//
//     final meters = Geolocator.distanceBetween(
//       c.lat, c.lng,
//       v.lat, v.lng,
//     );
//
//     final km = meters / 1000;
//     return "${km.toStringAsFixed(1)} km";
//   }
//
//   /// 🚀 preload + cache distances
//   Future<void> preloadDistanceCache({
//     required String customerAddress,
//     required List vendors,
//   }) async {
//
//     for (var v in vendors) {
//
//       final key = v.phone ?? v.shopName ?? v.toString();
//       final address = v.location;
//
//       if (address == null || address.isEmpty) continue;
//
//       // skip if already cached
//       if (distanceCache.containsKey(key)) continue;
//
//       final d = await distanceKm(customerAddress, address);
//
//       if (d != null) {
//         distanceCache[key] = d;
//       }
//     }
//
//     update(); // GetX rebuild
//   }
// }
//
