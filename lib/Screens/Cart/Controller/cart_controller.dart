import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Cart%20Model/item_model.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/Cart%20SQFlite%20DB/cart_sqflite_db.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Model/post_indent_items.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Repo/cart_repo.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  var commonService = CommonService.instance;
  final retailerController = Get.put(RetailersController());
  final productController = Get.put(ProductsController());

  final miniController = Get.put(MiniController());

  List<RetailerIndentItem> indentItem = [];
  var totalPrice = 0.0.obs;

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await miniController.getMiniUnitsList();
      fetchCartItems();
      calculateTotalPrice();
      update();
    });
  }

  createOrder() async {
    var postData = {
      "sales_agent_id": retailerController.retailersDetails.salesagent!.id,
      "producttype_id": productController.productTypeData.id,
      "retailer_id": retailerController.retailersDetails.id,
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "delivery_date": DateFormat('yyyy-MM-dd').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
      )),
      "description": "",
      "billing_address_id": retailerController.retailersDetails.defaultBillingAddress!.id,
      "shipping_address_id": retailerController.retailersDetails.defaultShippingAddress!.id,
      "indent_status": 1,
      "location_id": retailerController.retailersDetails.location!.id,
      "discount_percent": "0.00",
      "tax_percent": "0.00",
      "retailer_indent_items": indentItem
    };
    print("Add Retailer Post Data :::::: ${jsonEncode(postData)}");
    try {
      var data = await CartRepo().createOrder(postData);
      closeLoadingDialog();
      print('post data is $data');
      if (data != null) {
        // cartService.clearCart();
        clearCart();
        Get.toNamed(Routes.indentPlacedSuccessView);
      }
    } catch (e) {
      debugPrint(
        "Api Error Response: $e",
      );

      closeLoadingDialog();
    }
  }

  List<CartItem> cartItems = [];

  void fetchCartItems() async {
    var db = DatabaseHelper();
    var fetchedItems = await db.getCartItems();
    cartItems = fetchedItems.map((item) => CartItem.fromMap(item)).toList();
    calculateTotalPrice();
    update();
  }

  void addToCart(CartItem item) async {
    print('index value is ${item.toMap()}');
    var db = DatabaseHelper();
    await db.insertCartItem(item.toMap());
    fetchCartItems();
    update();
  }

  void updateCart(CartItem item) async {
    print('index value is ${item.toMap()}');
    var db = DatabaseHelper();
    await db.updateCartItem(item);
    fetchCartItems();
    update();
  }

  void removeFromCart(int id) async {
    print('cart item id  is $id');
    var db = DatabaseHelper();
    await db.deleteCartItem(id);
    fetchCartItems();
    update();
  }

  void clearCart() async {
    var db = DatabaseHelper();
    await db.clearCart();
    fetchCartItems();
    update();
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(0, (total, current) => total + (current.price * current.quantity * current.units));
    update();
  }
}
