
import 'package:flutter/material.dart';

import '../../controllers/categoriesController.dart';
import '../../model/GetCategoriesResponseModel.dart';

class CategoryDropdown extends StatefulWidget {
  Function(String) onSelected;

  CategoryDropdown({Key? key, required this.onSelected}) : super(key: key);
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selected;


  late GetCategoriesResponseModel categoriesResponseModel;
  @override
  void initState() {
    GetCategoriesController()
        .getCategories()
        .then((value) => setState(() {
      categoriesResponseModel = value;
      print("onscreen ${categoriesResponseModel.data?.length} categories");
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value:selected,
          hint: Text("Choose"),
          isExpanded: true,
          onChanged: (val) {
            setState(() {
              selected = val;
              widget.onSelected(val!); // ← Send back value to parent
              print("Selected Category: $selected");
            });
          },
          items: categoriesResponseModel.data?.map((e) {
            return DropdownMenuItem<String>(
              value: e.id,
              child: Text(e.categoryName ?? "Unknown"),
            );
          }).toList() ?? [],
        ),
      ),
    );
  }
}
