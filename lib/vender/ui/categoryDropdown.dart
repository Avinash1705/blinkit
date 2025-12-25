import 'package:flutter/material.dart';

import '../../controllers/categoriesController.dart';
import '../../model/GetCategoriesResponseModel.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(String) onSelected;

  const CategoryDropdown({Key? key, required this.onSelected})
      : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selected;
  GetCategoriesResponseModel? categoriesResponseModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final result = await GetCategoriesController().getCategories();
      setState(() {
        categoriesResponseModel = result;
        isLoading = false;
      });
      debugPrint(
          "Loaded ${categoriesResponseModel?.data?.length ?? 0} categories");
    } catch (e) {
      isLoading = false;
      debugPrint("Error loading categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selected,
          hint: isLoading
              ? const Text("Loading categories...")
              : const Text("Choose"),
          onChanged: isLoading
              ? null
              : (val) {
            setState(() {
              selected = val;
            });
            widget.onSelected(val!);
          },
          items: categoriesResponseModel?.data?.map((e) {
            return DropdownMenuItem<String>(
              value: e.id,
              child: Text(e.categoryName ?? "Unknown"),
            );
          }).toList() ??
              [],
        ),
      ),
    );
  }
}
