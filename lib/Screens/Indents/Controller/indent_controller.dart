import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Model/get_indents_details.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Model/get_indents_list.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Repo/indents_repo.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class IndentController extends GetxController {
  static IndentController get to => Get.find();
  var commonService = CommonService.instance;
  final retailersController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productTypeData = miniController.miniProductTypeList[1];
      retailerId = '';
      indentStatusId = '';
      dateRangeId = '';
      indentsIsRefresh = true;
      getIndentsList();
    });
  }

  initFilterState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      retailersController.retailersIsRefresh = true;
      retailersController.getRetailersList();
    });
  }

  final _productTypeData = MiniProductTypeData().obs;
  MiniProductTypeData get productTypeData => _productTypeData.value;
  set productTypeData(value) => _productTypeData.value = value;

  selectedProductTypeIndex(MiniProductTypeData data) {
    productTypeData = data;
    indentsIsRefresh = true;
    getIndentsList();

    update();
  }

  final RxInt _indentsCurrentPage = 1.obs;
  get indentsCurrentPage => _indentsCurrentPage.value;
  set indentsCurrentPage(value) => _indentsCurrentPage.value = value;

  final RxInt _indentsTotalPages = 1.obs;
  get indentsTotalPages => _indentsTotalPages.value;
  set indentsTotalPages(value) => _indentsTotalPages.value = value;

  final RxBool _indentsIsRefresh = false.obs;
  get indentsIsRefresh => _indentsIsRefresh.value;
  set indentsIsRefresh(value) => _indentsIsRefresh.value = value;

  final RxInt _indentsListCount = 0.obs;
  get indentsListCount => _indentsListCount.value;
  set indentsListCount(value) => _indentsListCount.value = value;

  final _indentsList = <GetIndentsData>[].obs;
  List<GetIndentsData> get indentsList => _indentsList;

  final RxString _retailerId = ''.obs;
  get retailerId => _retailerId.value;
  set retailerId(value) => _retailerId.value = value;

  final RxString _indentStatusId = ''.obs;
  get indentStatusId => _indentStatusId.value;
  set indentStatusId(value) => _indentStatusId.value = value;

  final RxString _dateRangeId = ''.obs;
  get dateRangeId => _dateRangeId.value;
  set dateRangeId(value) => _dateRangeId.value = value;

  getIndentsList({bool isLoading = true, int? status}) async {
    if (indentsIsRefresh) {
      _indentsList.value = <GetIndentsData>[];
      indentsCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (indentsCurrentPage > indentsTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': indentsCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'retailer': retailerId,
      'indent_status': indentStatusId,
      'date_range': dateRangeId,
      'product_type': productTypeData.id,
    };

    try {
      final data = await IndentsRepo().getIndentsList(filterParams);

      if (data != null) {
        indentsListCount = data.count;
        _indentsList.value = [...indentsList, ...data.results ?? []];
        var seen = <String>{};
        List<GetIndentsData> filtered = _indentsList.where((field) => seen.add(field.id!.toString())).toList();
        _indentsList.value = filtered;
        indentsIsRefresh = false;

        closeLoadingDialog();
        indentsTotalPages = (indentsListCount / CommonService.instance.pageSize).ceil();
        indentsCurrentPage++;
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

  final _indentsDetails = GetIndentsDetails().obs;
  GetIndentsDetails get indentsDetails => _indentsDetails.value;
  set indentsDetails(value) => _indentsDetails.value = value;

  getIndentsDetails(id) async {
    showLoadingDialog();
    try {
      final data = await IndentsRepo().getIndentsDetails(id);
      if (data != null) {
        _indentsDetails.value = data;
        print('items list ${(jsonEncode(indentsDetails.retailerOrderItems!.length))}');

        update();
        closeLoadingDialog();

        Get.toNamed(Routes.indentViewById);
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
}
