import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/ui/widgets/uihelper.dart';
import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart'
as allVenders;

import '../../model/GetCategoriesResponseModel.dart';
import 'SubCategoryNew.dart';

class CustomSearchAppBar extends StatefulWidget {
  final List<allVenders.Data>? allVenderData;
  const CustomSearchAppBar({
    super.key,
    required this.allVenderData,
  });

  @override
  State<CustomSearchAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomSearchAppBar> {
  final TextEditingController _searchController = TextEditingController();
  List<allVenders.Data> filteredVendors = [];
  Data1 data1 = Data1.withValues(
      categoryName: "categoryName", categoryImg: "categoryImg", id: "id");
  @override
  void initState() {
    super.initState();
    filteredVendors = widget.allVenderData ?? [];
    _searchController.addListener(_filterVendors);
  }

  void _filterVendors() {
    const int targetPin = 226021;
    final query = _searchController.text.toLowerCase().trim();

    setState(() {
      // Step 1️⃣: Filter vendors based on search query
      List<allVenders.Data> results;
      if (query.isEmpty) {
        results = widget.allVenderData ?? [];
      } else {
        results = widget.allVenderData!
            .where((vendor) =>
        (vendor.venderName ?? "").toLowerCase().contains(query) ||
            (vendor.shopName ?? "").toLowerCase().contains(query))
            .toList();
      }

      // Step 2️⃣: Sort vendors by distance from targetPin
      results.sort((a, b) {
        int aPin = int.tryParse(a.pincode ?? '') ?? 0;
        int bPin = int.tryParse(b.pincode ?? '') ?? 0;

        // Calculate absolute difference from target
        int aDiff = (aPin - targetPin).abs();
        int bDiff = (bPin - targetPin).abs();

        return aDiff.compareTo(bDiff); // nearest first
      });

      // Step 3️⃣: Update filtered list
      filteredVendors = results;

      // Debug logs
      print("Search Query: $query");
      print("Filtered Vendors: ${filteredVendors.length}");
      if (filteredVendors.isNotEmpty) {
        print("Nearest Vendor: ${filteredVendors.first.venderName} (${filteredVendors.first.pincode})");
      }
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 👤 PROFILE + SEARCH WITH ICON
          Stack(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search for vendors, shops...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xfff2f2f2),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 🧾 FILTERED VENDOR LIST
          Expanded(
            child: filteredVendors.isEmpty
                ? const Center(
              child: Text(
                "No vendors found",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredVendors.length,
              itemBuilder: (context, index) {
                final vendor = filteredVendors[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.storefront,
                        color: Colors.deepOrangeAccent),
                    title: Text(
                      vendor.venderName ?? "Vendor Name",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(vendor.shopName ?? "Shop Name"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        size: 16, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                        Text("Selected: ${vendor.venderName ?? ''}"),
                        //redirect to particular vendor page

                      ));
                      Get.to(SubCategoryNew(
                        data: Data1.withValues(
                          id: widget.allVenderData![index].phone.toString(),
                          categoryName: widget.allVenderData![index]
                              .shopName
                              .toString(),
                        ),
                      ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
