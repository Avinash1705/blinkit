class CartItem {
  final String productId;
  final String title;
  final String img;
   int quantity;
  final double price;
  int? existingQuantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.img,
    required this.quantity,
    required this.price,
  required ,this.existingQuantity,
  });


  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      title: json['title'],
      img: json['img'],
      quantity: json['quantity'],
      price: json['price'],
existingQuantity: json['existingQuantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'img': img,
    'quantity': quantity,
    'price': price,
    'existingQuantity': existingQuantity,
  };
}

