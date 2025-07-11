class GetCategoriesResponseModel {
  String? status;
  int? code;
  int? count;
  List<Data>? data;

  GetCategoriesResponseModel({this.status, this.code, this.count, this.data});

  GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? categoryName;
  String? categoryImg;
  String? id;
  Data();
  Data.withValues({this.categoryName, this.categoryImg, this.id});


  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['id'] = this.id;
    return data;
  }
}
class Data1 {
  String? categoryName;
  String? categoryImg;
  String? id;
  Data1({String? categoryName, String? categoryImg, String? id});
  Data1.withValues({this.categoryName, this.categoryImg, this.id});


  Data1.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['id'] = this.id;
    return data;
  }
}