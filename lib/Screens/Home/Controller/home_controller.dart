import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Controller/profile_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final profileController = Get.put(ProfileController());
  final productController = Get.put(ProductsController());
  final retailerController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  RxInt pageIndex = 0.obs;
  onchangeIndex(int? index) async {
    pageIndex.value = index!;

    update();
  }

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pageIndex.value = 0;
      profileController.getProfileDetails();
      miniController.miniProductTypeIsRefresh = true;
      miniController.getMiniProductTypeList();
      if (CommonService.instance.retailerId != '') {
        retailerController.getRetailersDetails(CommonService.instance.retailerId, from: 'home');
      }
    });
  }
}
