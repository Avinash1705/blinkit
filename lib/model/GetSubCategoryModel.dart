class GetSubCategoryModel {
  String? status;
  int? code;
  int? count;
  List<Data>? data;

  GetSubCategoryModel({this.status, this.code, this.count, this.data});

  GetSubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? itemName;
  String? itemImg;
  String? phone;
  String? id;
  String? price;
  String? itemDescription;

  Data(
      {this.categoryId,
        this.itemName,
        this.itemImg,
        this.phone,
        this.id,
        this.price,
        this.itemDescription});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    itemName = json['item_name'];
    itemImg = json['item_img'];
    phone = json['phone'];
    id = json['id'];
    price = json['price'];
    itemDescription = json['item_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['item_name'] = this.itemName;
    data['item_img'] = this.itemImg;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['price'] = this.price;
    data['item_description'] = this.itemDescription;
    return data;
  }
}

