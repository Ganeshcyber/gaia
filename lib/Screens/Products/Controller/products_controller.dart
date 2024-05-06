import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Alert%20Dailog/retailer_changed_alert_dailog.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Model/get_categories_list.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Model/get_products_list.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Repo/product_repo.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailer_details.dart';

class ProductsController extends GetxController {
  static ProductsController get to => Get.find();
  var commonService = CommonService.instance;

  final retailersController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  final _retailerData = GetRetailersDetails().obs;
  GetRetailersDetails get retailerData => _retailerData.value;
  set retailerData(value) => _retailerData.value = value;

  // final cartService = CartService();
  // List<Map<String, dynamic>> allItems = [];

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // selectedIndex = 1;
      retailersController.retailersIsRefresh = true;
      await retailersController.getRetailersList();
      commonService.retailerName = await SessionManager.getRetailerName();
      commonService.retailerId = await SessionManager.getRetailerId();
      debugPrint("Retailer name::::::${commonService.retailerName}");
      debugPrint("Retailer Id::::::${commonService.retailerId}");
      productTypeData = miniController.miniProductTypeList[1];
      categoriesIsRefresh = true;
      await getCategoriesList();
      // if (commonService.retailerId != '') {
      //   retailersController.getRetailersDetails(commonService.retailerId, from: 'home');
      // }
    });
  }

  // final RxInt _selectedIndex = 0.obs;
  // get selectedIndex => _selectedIndex.value;
  // set selectedIndex(value) => _selectedIndex.value = value;

  final _productTypeData = MiniProductTypeData().obs;
  MiniProductTypeData get productTypeData => _productTypeData.value;
  set productTypeData(value) => _productTypeData.value = value;

  selectedProductTypeIndex(MiniProductTypeData data) {
    // selectedIndex = index;
    CartController cartController = Get.find<CartController>();

    if (cartController.cartItems.isNotEmpty) {
      if (productTypeData.id != data.id) {
        Get.dialog(RetailerChangedAlertDialog(
          newStr: data.name!,
          oldStr: productTypeData.name!,
          productTypeData: data,
          from: 'productType',
        ));
      }
    } else {
      productTypeData = data;
      categoriesIsRefresh = true;
      getCategoriesList();
    }

    update();
  }

  final RxInt _categoriesCurrentPage = 1.obs;
  get categoriesCurrentPage => _categoriesCurrentPage.value;
  set categoriesCurrentPage(value) => _categoriesCurrentPage.value = value;

  final RxInt _categoriesTotalPages = 1.obs;
  get categoriesTotalPages => _categoriesTotalPages.value;
  set categoriesTotalPages(value) => _categoriesTotalPages.value = value;

  final RxBool _categoriesIsRefresh = false.obs;
  get categoriesIsRefresh => _categoriesIsRefresh.value;
  set categoriesIsRefresh(value) => _categoriesIsRefresh.value = value;

  final RxInt _categoriesListCount = 0.obs;
  get categoriesListCount => _categoriesListCount.value;
  set categoriesListCount(value) => _categoriesListCount.value = value;

  final _categoriesList = <GetCategoriesData>[].obs;
  List<GetCategoriesData> get categoriesList => _categoriesList;

  getCategoriesList({bool isLoading = true, int? status}) async {
    if (categoriesIsRefresh) {
      _categoriesList.value = <GetCategoriesData>[];
      categoriesCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (categoriesCurrentPage > categoriesTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'product_type': productTypeData.id,
      'page': categoriesCurrentPage,
      'page_size': CommonService.instance.pageSize,
    };

    try {
      final data = await ProductsRepo().getCategoriesList(filterParams);

      if (data != null) {
        categoriesListCount = data.count;
        _categoriesList.value = [...categoriesList, ...data.results ?? []];
        var seen = <String>{};
        List<GetCategoriesData> filtered = _categoriesList.where((field) => seen.add(field.id!.toString())).toList();
        _categoriesList.value = filtered;
        categoriesIsRefresh = false;

        closeLoadingDialog();
        categoriesTotalPages = (categoriesListCount / CommonService.instance.pageSize).ceil();
        categoriesCurrentPage++;
        update();
        return true;
      } else {
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }

  initProductsState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      miniController.miniUnitsIsRefresh = true;
      await miniController.getMiniUnitsList();
      productsIsRefresh = true;
      await getProductsList();
      CartController cartController = Get.find<CartController>();
      cartController.fetchCartItems();
      cartController.update();
      update();
    });
  }

  final RxString _catId = ''.obs;
  get catId => _catId.value;
  set catId(value) => _catId.value = value;

  final RxString _catName = ''.obs;
  get catName => _catName.value;
  set catName(value) => _catName.value = value;

  final RxInt _productsCurrentPage = 1.obs;
  get productsCurrentPage => _productsCurrentPage.value;
  set productsCurrentPage(value) => _productsCurrentPage.value = value;

  final RxInt _productsTotalPages = 1.obs;
  get productsTotalPages => _productsTotalPages.value;
  set productsTotalPages(value) => _productsTotalPages.value = value;

  final RxBool _productsIsRefresh = false.obs;
  get productsIsRefresh => _productsIsRefresh.value;
  set productsIsRefresh(value) => _productsIsRefresh.value = value;

  final RxInt _productsListCount = 0.obs;
  get productsListCount => _productsListCount.value;
  set productsListCount(value) => _productsListCount.value = value;

  final _productsList = <GetProductsData>[].obs;
  List<GetProductsData> get productsList => _productsList;

  final RxString _sortType = ''.obs;
  get sortType => _sortType.value;
  set sortType(value) => _sortType.value = value;

  getProductsList({bool isLoading = true, int? status}) async {
    if (productsIsRefresh) {
      _productsList.value = <GetProductsData>[];
      productsCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (productsCurrentPage > productsTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{'page': productsCurrentPage, 'page_size': CommonService.instance.pageSize, 'ordering': sortType};

    try {
      final data = await ProductsRepo().getProductsList(catId, commonService.retailerId, filterParams);

      if (data != null) {
        productsListCount = data.count;
        _productsList.value = [...productsList, ...data.results ?? []];
        var seen = <String>{};
        List<GetProductsData> filtered = _productsList.where((field) => seen.add(field.id!.toString())).toList();
        _productsList.value = filtered;
        productsIsRefresh = false;

        closeLoadingDialog();
        productsTotalPages = (productsListCount / CommonService.instance.pageSize).ceil();
        productsCurrentPage++;
        update();
        return true;
      } else {
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }

  // List<CartItem> cartItems = [];
  // var totalPrice = 0.0.obs;

  // void fetchCartItems() async {
  //   var db = DatabaseHelper();
  //   var fetchedItems = await db.getCartItems();
  //   cartItems = fetchedItems.map((item) => CartItem.fromMap(item)).toList();
  //   print('index value is ${cartItems.length}');
  //   calculateTotalPrice();
  //   update();
  // }

  // void addToCart(CartItem item) async {
  //   print('index value is ${item.toMap()}');
  //   var db = DatabaseHelper();
  //   await db.insertCartItem(item.toMap());
  //   fetchCartItems();
  //   update();
  // }

  // void updateCart(CartItem item) async {
  //   print('index value is ${item.toMap()}');
  //   var db = DatabaseHelper();
  //   await db.updateCartItem(item);
  //   fetchCartItems();
  //   update();
  // }

  // void removeFromCart(int id) async {
  //   print('cart item id  is $id');
  //   var db = DatabaseHelper();
  //   await db.deleteCartItem(id);
  //   fetchCartItems();
  //   update();
  // }

  // void clearCart() async {
  //   var db = DatabaseHelper();
  //   await db.clearCart();
  //   fetchCartItems();
  //   update();
  // }

  // void calculateTotalPrice() {
  //   totalPrice.value = cartItems.fold(0, (total, current) => total + (current.price * current.quantity * current.units));
  //   update();
  // }
}
