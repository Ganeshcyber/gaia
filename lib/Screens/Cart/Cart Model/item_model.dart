class CartItem {
  int? id;
  String? productId;
  String name;
  double price;
  String image;
  int quantity;
  double units;
  String unitsId;
  String unitsName;

  CartItem({
    this.id,
    this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.units,
    required this.unitsId,
    required this.unitsName,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      quantity: map['quantity'],
      units: map['units'],
      unitsId: map['unitsId'],
      unitsName: map['unitsName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'units': units,
      'unitsId': unitsId,
      'unitsName': unitsName,
    };
  }
}
