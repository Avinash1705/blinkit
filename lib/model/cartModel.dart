class CartItem {
  final String productId;
  final String title;
  final String img;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.title,
    required this.img,
    required this.quantity,
    required this.price,
  });


  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      title: json['title'],
      img: json['img'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'img': img,
    'quantity': quantity,
    'price': price,
  };
}

