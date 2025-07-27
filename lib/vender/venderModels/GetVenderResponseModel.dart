class GetVenderResponseModel {
  String? status;
  int? code;
  int? count;
  List<Data>? data;

  GetVenderResponseModel({this.status, this.code, this.count, this.data});

  GetVenderResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? venderName;
  String? venderId;
  String? shopName;
  String? phone;
  String? location;
  String? valid;

  Data(
      {this.venderName,
        this.venderId,
        this.shopName,
        this.phone,
        this.location,this.valid});

  Data.fromJson(Map<String, dynamic> json) {
    venderName = json['vender_name'];
    venderId = json['vender_id'];
    shopName = json['shop_name'];
    phone = json['phone'];
    location = json['location'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vender_name'] = this.venderName;
    data['vender_id'] = this.venderId;
    data['shop_name'] = this.shopName;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['valid'] = this.valid;
    return data;
  }
}