

class CartItem {
  final String id;
  final String title;
  final String size;
  final int price;
  final String? productOwnerId;
  final String? userProfit;
  final String? imageUrl;
  final String? qty;

  CartItem({
    required this.id,
    required this.title,
    required this.size,
    required this.price,
    required this.productOwnerId,
    required this.userProfit,
    required this.imageUrl,
    required this.qty,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      size: json['size'],
      price: json['price'],
      productOwnerId: json['productOwnerId'],
      userProfit: json['userProfit'],
      imageUrl: json['imageUrl'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'size': size,
      'price': price,
      'productOwnerId':productOwnerId,
      'userProfit':userProfit,
      'imageUrl':imageUrl,
      'qty':qty,
    };
  }
}
