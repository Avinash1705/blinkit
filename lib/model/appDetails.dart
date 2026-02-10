

class AppDetailModel {
  String? status;
  int? code;
  int? count;
  List<Data>? data;

  AppDetailModel({this.status, this.code, this.count, this.data});

  AppDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? appName;
  String? appIcon;
  String? paymentUser;

  Data({this.appName, this.appIcon});

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appIcon = json['app_icon'];
    paymentUser = json['paymentUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['app_icon'] = this.appIcon;
    data['paymentUser'] = this.paymentUser;
    return data;
  }
}