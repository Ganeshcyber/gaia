import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_indent_items.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_receipts_details.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_receipts_list.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Repo/receipts_repo.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

class ReceiptController extends GetxController {
  static ReceiptController get to => Get.find();
  var commonService = CommonService.instance;

  final retailersController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productTypeData = miniController.miniProductTypeList[1];
      receiptsIsRefresh = true;
      getReceiptsList();
      update();
    });
  }

  initAddReceiptState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productTypeData = MiniProductTypeData();
      update();
    });
  }

  initFilterState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      retailersController.retailersIsRefresh = true;
      retailersController.getRetailersList();
    });
  }

  // final RxInt _selectedIndex = 0.obs;
  // get selectedIndex => _selectedIndex.value;
  // set selectedIndex(value) => _selectedIndex.value = value;

  final _productTypeData = MiniProductTypeData().obs;
  MiniProductTypeData get productTypeData => _productTypeData.value;
  set productTypeData(value) => _productTypeData.value = value;

  selectedProductTypeIndex(MiniProductTypeData data) {
    productTypeData = data;
    receiptsIsRefresh = true;
    getReceiptsList();

    update();
  }

  final RxInt _receiptsCurrentPage = 1.obs;
  get receiptsCurrentPage => _receiptsCurrentPage.value;
  set receiptsCurrentPage(value) => _receiptsCurrentPage.value = value;

  final RxInt _receiptsTotalPages = 1.obs;
  get receiptsTotalPages => _receiptsTotalPages.value;
  set receiptsTotalPages(value) => _receiptsTotalPages.value = value;

  final RxBool _receiptsIsRefresh = false.obs;
  get receiptsIsRefresh => _receiptsIsRefresh.value;
  set receiptsIsRefresh(value) => _receiptsIsRefresh.value = value;

  final RxInt _receiptsListCount = 0.obs;
  get receiptsListCount => _receiptsListCount.value;
  set receiptsListCount(value) => _receiptsListCount.value = value;

  final _receiptsList = <GetReceiptsData>[].obs;
  List<GetReceiptsData> get receiptsList => _receiptsList;

  final RxString _retailerId = ''.obs;
  get retailerId => _retailerId.value;
  set retailerId(value) => _retailerId.value = value;

  final RxString _indentStatusId = ''.obs;
  get indentStatusId => _indentStatusId.value;
  set indentStatusId(value) => _indentStatusId.value = value;

  final RxString _dateRangeId = ''.obs;
  get dateRangeId => _dateRangeId.value;
  set dateRangeId(value) => _dateRangeId.value = value;

  getReceiptsList({bool isLoading = true, int? status}) async {
    if (receiptsIsRefresh) {
      _receiptsList.value = <GetReceiptsData>[];
      receiptsCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (receiptsCurrentPage > receiptsTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': receiptsCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'retailer': retailerId,
      'indent_status': indentStatusId,
      'date_range': dateRangeId,
      'product_type': productTypeData.id,
    };

    try {
      final data = await ReceiptsRepo().getReceiptsList(filterParams);

      if (data != null) {
        receiptsListCount = data.count;
        _receiptsList.value = [...receiptsList, ...data.results ?? []];
        var seen = <String>{};
        List<GetReceiptsData> filtered = _receiptsList.where((field) => seen.add(field.id!.toString())).toList();
        _receiptsList.value = filtered;
        receiptsIsRefresh = false;

        closeLoadingDialog();
        receiptsTotalPages = (receiptsListCount / CommonService.instance.pageSize).ceil();
        receiptsCurrentPage++;
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

  final _receiptsDetails = GetReceiptsDetails().obs;
  GetReceiptsDetails get receiptsDetails => _receiptsDetails.value;
  set receiptsDetails(value) => _receiptsDetails.value = value;

  getReceiptsDetails(id) async {
    showLoadingDialog();
    try {
      final data = await ReceiptsRepo().getReceiptsDetails(id);
      if (data != null) {
        _receiptsDetails.value = data;

        update();
        closeLoadingDialog();

        Get.toNamed(Routes.receiptsViewById);
      } else {
        debugPrint("Api Error Response error:: ");
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();

      debugPrint("Api  Response error:: $e ");
      rethrow;
    }
  }

  final _indentItemsDetails = GetIndentItemsDetails().obs;
  GetIndentItemsDetails get indentItemsDetails => _indentItemsDetails.value;
  set indentItemsDetails(value) => _indentItemsDetails.value = value;

  final _indentItemsList = IndentItemsList().obs;
  IndentItemsList get indentItemsList => _indentItemsList.value;
  set indentItemsList(value) => _indentItemsList.value = value;

  final _retailerData = GetRetailersData().obs;
  GetRetailersData get retailerData => _retailerData.value;
  set retailerData(value) => _retailerData.value = value;

  // final RxString _productTypeId = ''.obs;
  // get productTypeId => _productTypeId.value;
  // set productTypeId(value) => _productTypeId.value = value;

  getIndentItemsDetails(retaillerId, productTypeId) async {
    showLoadingDialog();
    try {
      closeLoadingDialog();
      final data = await ReceiptsRepo().getIndentItemsDetails(retaillerId, productTypeId);
      if (data != null) {
        _indentItemsDetails.value = data;
        update();

        // Get.toNamed(Routes.receiptsViewById);
      } else {
        debugPrint("Api Error Response error:: ");
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();

      debugPrint("Api  Response error:: $e ");
      rethrow;
    }
  }

  // List<IndentItemsList> itemList = [];
  TextEditingController quantityTF = TextEditingController();
  TextEditingController priceTF = TextEditingController();
  TextEditingController totalPriceTF = TextEditingController();

  addReceipt() async {
    var postData = {
      "retailer_id": retailerData.id,
      "product_type_id": productTypeData.id,
      "discount_percent": "0.00",
      "discount_amount": "0.00",
      "tax_percent": "0.00",
      "tax_amount": "0.00",
      "net": "0.00",
      "receipt_items": indentItemsDetails.items
    };
    print("Add Retailer Post Data :::::: ${jsonEncode(postData)}");
    try {
      var data = await ReceiptsRepo().addReceipts(postData);
      closeLoadingDialog();
      if (data != null) {
        Get.back();
        print("Add Retailer Post Data :::::: ${jsonEncode(postData)}");
        // itemList = [];
        receiptsIsRefresh = true;
        getReceiptsList();
      }
    } catch (e) {
      debugPrint(
        "Api Error Response: $e",
      );

      closeLoadingDialog();
    }
  }
}
