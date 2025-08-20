import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiggy/domain/AppConstants.dart';

class UiHelper {

  static CustomImage({required String img}) {
    return Image.asset("assets/images/$img");
  }
  // static CustomImageNetwork({required String img, required int height, required int width}) {
  //   return Image.network(img);
  // }
  //category image
  static CustomImageNetworkCategory({required String img}) {
    // print("test gjgj $img");
    //   print("test img https://${AppConstants.ip}/img/category/$img");
    return Image.network("${AppConstants.ssl}://${AppConstants.ip}/fluxKart/img/category/$img",fit: BoxFit.cover);
  }
  //Sub category image
  static CustomImageNetworkSubCategory({required String img}) {

    return Image.network("${AppConstants.ssl}://${AppConstants.ip}/fluxKart/img/subCategory/$img",fit: BoxFit.cover,);
  }
  //Sub category image
  static CustomImageNetworkShop({required String img}) {

    return Image.network("${AppConstants.ssl}://${AppConstants.ip}/fluxKart/img/shop/$img",fit: BoxFit.cover,);
  }
  //Profile  image
  static CustomImageNetworkCustomerProfile({required String img}) {
    return NetworkImage("${AppConstants.ssl}://${AppConstants.ip}/fluxKart/img/profile/$img");
    return Image.network("${AppConstants.ssl}://${AppConstants.ip}/fluxKart/img/profile/$img",fit: BoxFit.cover,);
  }
  static fullUrlImageNetworkCategory({required String img}) {
   //getting full url from server
    return Image.network(img);
  }
  static CustomImageNetworkNoDimension({required String img}) {
    return Image.network(img);
  }
  static CustomText(
      {required String text,
      required Color color,
      required FontWeight fontWeight,
      String? fontfamily,
      required double fontsize}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
          fontSize: fontsize,
          fontFamily: fontfamily ?? "regular",
          fontWeight: fontWeight,
          color: color),
    );
  }
  static CustomTextField({required TextEditingController controller}){
    return Container(
      height: 40,
      width: 360,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Color(0XFFC5C5C5)
          )
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Search 'ice-cream'",
            prefixIcon: Image.asset("assets/images/search.png"),
            suffixIcon: Image.asset("assets/images/mic 1.png"),
            border: InputBorder.none
        ),
      ),
    );
  }

  static CustomButton(VoidCallback callback){
    return InkWell(
      onTap: callback,
      child: Container(
        height: 18,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Color(0XFF27AF34)
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Center(child: Text("Add",style: TextStyle(fontSize: 8,color: Color(0XFF27AF34)),),),
      ),
    );
  }
}
