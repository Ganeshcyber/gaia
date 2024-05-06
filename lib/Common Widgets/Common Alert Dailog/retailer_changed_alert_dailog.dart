import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

class RetailerChangedAlertDialog extends StatelessWidget {
  final String oldStr;
  final String newStr;
  final String from;
  final MiniProductTypeData? productTypeData;
  final GetRetailersData? retailerData;
  RetailerChangedAlertDialog({Key? key, required this.oldStr, required this.newStr, required this.from, this.productTypeData, this.retailerData})
      : super(key: key);

  final cartController = Get.put(CartController());
  final productController = Get.put(ProductsController());
  final retailersController = Get.put(RetailersController());

  @override
  Widget build(BuildContext context) {
    // var commonService = CommonService.instance;

    return PopScope(
      canPop: false,
      child: AlertDialog(
          contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
          title: const Text(
            "Replace Retailer Cart",
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Your cart contains items from "$oldStr". Do you want to discard the selection and add "$newStr" instead?',
            textAlign: TextAlign.center,
          ),
          // actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: Size(MediaQuery.of(context).size.width / 3, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    side: BorderSide(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 3,
                  height: 40,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Theme.of(context).colorScheme.primary,
                  // minWidth: 85,
                  // height: 35,
                  // elevation: 0.0,
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  // color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Get.back();
                    cartController.clearCart();
                    if (from == 'productType') {
                      productController.productTypeData = productTypeData;
                      productController.categoriesIsRefresh = true;
                      productController.getCategoriesList();
                    } else {
                      retailersController.getRetailersDetails(retailerData!.id, from: 'home');
                      CommonService.instance.retailerName = retailerData!.fullname!;
                      CommonService.instance.retailerId = retailerData!.id!;

                      SessionManager.setRetailerName(retailerData!.fullname ?? '');
                      SessionManager.setRetailerId(retailerData!.id ?? '');
                    }
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
