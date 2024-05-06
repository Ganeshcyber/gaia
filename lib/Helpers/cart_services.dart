// import 'dart:convert';

// import 'package:get_storage/get_storage.dart';
// import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';

// class CartService {
//   final _storage = GetStorage();

//   Future<void> addItem(String id, String name, String image, double price, int quantity, MiniUnitsData size) async {
//     print('cart items are $id, $name,$size,$quantity,$price');
//     final List<dynamic>? items = _getItems();
//     if (items == null) {
//       _storage.write(
//           'cart',
//           json.encode([
//             {
//               'id': id,
//               'name': name,
//               'image': image,
//               'price': price,
//               'quantity': quantity,
//               'size': size,
//             }
//           ]));
//     } else {
//       final existingItemIndex = items.indexWhere((item) => item['id'] == id);
//       if (existingItemIndex != -1) {
//         items[existingItemIndex]['quantity'] += quantity;
//       } else {
//         items.add({
//           'id': id,
//           'name': name,
//           'image': image,
//           'price': price,
//           'quantity': quantity,
//           'size': size,
//         });
//       }
//       _storage.write('cart', json.encode(items));
//     }
//   }

//   Future<void> updateItem(String id, int quantity, MiniUnitsData size) async {
//     final List<dynamic>? items = _getItems();
//     if (items != null) {
//       final existingItemIndex = items.indexWhere((item) => item['id'] == id);
//       if (existingItemIndex != -1) {
//         items[existingItemIndex]['quantity'] = quantity;
//         items[existingItemIndex]['size'] = size;
//         _storage.write('cart', json.encode(items));
//       }
//     }
//   }

//   Future<void> removeItem(String id) async {
//     final List<dynamic>? items = _getItems();
//     if (items != null) {
//       final updatedItems = items.where((item) => item['id'] != id).toList();
//       _storage.write('cart', json.encode(updatedItems));
//     }
//   }

//   Future<List<Map<String, dynamic>>> getItems() async {
//     final List<dynamic>? items = _getItems();
//     if (items == null) return [];
//     return items.map((item) => item as Map<String, dynamic>).toList();
//   }

//   List<dynamic>? _getItems() {
//     final jsonString = _storage.read('cart');
//     if (jsonString == null) return null;
//     return json.decode(jsonString) as List<dynamic>;
//   }

//   Future<void> clearCart() async {
//     _storage.remove('cart');
//   }

//   Future<double> getTotalPrice() async {
//     final List<dynamic>? items = _getItems();
//     if (items == null) return 0.0;
//     return items.fold(0.0, (total, item) {
//       final price = item['price'] as double;
//       final quantity = item['quantity'] as int;
//       final units = double.parse(item['size']['units']);
//       return total = (price * quantity * units);
//     });
//   }
// }
