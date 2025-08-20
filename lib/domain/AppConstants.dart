

class AppConstants {

  // static const String ip = "192.168.1.24:8080";
  // static const String ip = "172.20.10.4:8080";
  // static const String ip = "royalblue-opossum-328842.hostingersite.com";
  static const String ip = "avitechly.com";
  // static const String ip = "localhost:80";
  static String ssl =  "https";
  static final String appDetail = "$ssl://$ip/fluxKart/apis/app_detail.php";
  static  String getAllVenders = "$ssl://$ip/fluxKart/apis/get_venders.php";
  static  String registerVenders = "$ssl://$ip/fluxKart/apis/register_vender.php";
  /*Register customer*/
  static  String registerCustomer = "$ssl://$ip/fluxKart/apis/register_customer.php";
  static  String getRegisterCustomer = "$ssl://$ip/fluxKart/apis/get_customerRegister.php";
  // https://avitechly.com/fluxKart/apis/get_customerRegister.php?phone=9868868686
  static  String addItems = "$ssl://$ip/fluxKart/apis/addSubItem.php";
  // httpss://royalblue-opossum-328842.hostingersite.com/fluxKart/apis/get_categories.php
  static  String getAllCategories = "$ssl://$ip/fluxKart/apis/get_categories.php";
  static  String getSubCategories = "$ssl://$ip/fluxKart/apis/get_subCategory.php";
  static  String getOrderedPlaced = "$ssl://$ip/fluxKart/apis/getOrderPlaced.php";
  static  String updateValidity = "$ssl://$ip/fluxKart/apis/updateSubcription.php";
  // http://localhost/fluxkart/apis/getSpecificVenderCategories.php?phone=$phone
  static  String getSpecificVenderCategories = "$ssl://$ip/fluxKart/apis/getSpecificVenderCategories.php";
  static  String updateSubcategoryAndSoldItem = "$ssl://$ip/fluxKart/apis/updateSubcategoryAndSoldItem.php";
  static  String updateSoldItemLog = "$ssl://$ip/fluxKart/apis/updateSoldItemLog.php";
  static  String updateAppDetail = "$ssl://$ip/fluxKart/apis/updateAppDetail.php";
  static  String updateEditProductInVender = "$ssl://$ip/fluxKart/apis/updateEditProductInVender.php";


  //Order table Format name
  static  String orderTableFormat(String tableName){
    return "orders_$tableName";
  }

}