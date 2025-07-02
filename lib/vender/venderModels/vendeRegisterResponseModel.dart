class vendeRegisterResponseModel {
  String? status;
  int? code;
  int? count;
  Data? data;

  vendeRegisterResponseModel({this.status, this.code, this.count, this.data});

  vendeRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    count = json['count'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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

  Data(
      {this.venderName,
        this.venderId,
        this.shopName,
        this.phone,
        this.location});

  Data.fromJson(Map<String, dynamic> json) {
    venderName = json['vender_name'];
    venderId = json['vender_id'];
    shopName = json['shop_name'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vender_name'] = this.venderName;
    data['vender_id'] = this.venderId;
    data['shop_name'] = this.shopName;
    data['phone'] = this.phone;
    data['location'] = this.location;
    return data;
  }
}