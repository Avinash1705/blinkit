class CustomerOrderResponseModel {
  bool? success;
  Orders? orders;

  CustomerOrderResponseModel({this.success, this.orders});

  CustomerOrderResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  List<Date>? date;

  Orders({this.date});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = <Date>[];
      json['date'].forEach((v) {
        date!.add(new Date.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Date {
  String? id;
  String? customerName;
  String? customerPhone;
  String? orderId;
  String? itemImg;
  String? itemQuantity;
  String? customerLocation;
  String? date;

  Date(
      {this.id,
        this.customerName,
        this.customerPhone,
        this.orderId,
        this.itemImg,
        this.itemQuantity,
        this.customerLocation,
        this.date});

  Date.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    orderId = json['order_id'];
    itemImg = json['item_img'];
    itemQuantity = json['item_quantity'];
    customerLocation = json['customer_location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['order_id'] = this.orderId;
    data['item_img'] = this.itemImg;
    data['item_quantity'] = this.itemQuantity;
    data['customer_location'] = this.customerLocation;
    data['date'] = this.date;
    return data;
  }
}