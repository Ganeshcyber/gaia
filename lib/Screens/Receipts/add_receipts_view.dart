import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_receipt_product_card.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Controller/receipts_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_indent_items.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/add_product_to_receipt_bottom_sheet.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

class AddReceiptView extends StatefulWidget {
  const AddReceiptView({super.key});

  @override
  State<AddReceiptView> createState() => _AddReceiptViewState();
}

class _AddReceiptViewState extends State<AddReceiptView> {
  final controller = Get.put(ReceiptController());
  final retailersController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Bottom Sheet for OrderSummary

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        titleChild: const Text(
          'Add Receipt',
        ),
        leadingChild: const Icon(
          Icons.arrow_back_rounded,
        ),
        leadingLink: () {
          Get.back();
        },
      ),
      body: GetBuilder<ReceiptController>(
        initState: (_) => ReceiptController.to.initAddReceiptState(),
        builder: (value) => SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonComponents.defaultTextField(context,
                                  title: 'Date',
                                  hintText: 'Select',
                                  enable: false,
                                  readOnly: true,
                                  controller: TextEditingController(text: DateFormat('MMM dd yyyy  hh:mm a').format(DateTime.now()))
                                  // validator: (val) {
                                  //   if (val == '') {
                                  //     return 'Date is required';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  // onTap: () async {
                                  //   final DateTime? picked = await showDatePicker(
                                  //       context: context,
                                  //       initialDate: DateTime.now(),
                                  //       lastDate: DateTime(
                                  //         DateTime.now().year,
                                  //         DateTime.now().month + 2,
                                  //         DateTime.now().day,
                                  //       ),
                                  //       firstDate: DateTime.now());

                                  //   // controller.startDateController.text = picked != null ? DateFormat(AppConstants.dobFormat).format(picked) : '';
                                  //   // controller.scheduleTimeController.text = picked != null ? DateFormat(AppConstants.timeFormat).format(picked) : '';
                                  //   // controller.preventiveRequestData.startDate = picked;
                                  // },
                                  ),
                              Container(
                                height: 20,
                              ),
                              CommonComponents.defaultDropdownSearch<GetRetailersData>(
                                context,
                                title: "Retailer",
                                hintText: "Select",
                                // prefixIcon: const Icon(
                                //   Icons.pin_drop_outlined,
                                //   size: 20,
                                // ),
                                // items: retailersList,
                                asyncItems: (String? filter) async {
                                  await retailersController.getRetailersList();
                                  return retailersController.retailersList;
                                },
                                itemBuilder: (context, GetRetailersData? item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(
                                            // border: Border.all(color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                          ),
                                    child: ListTile(
                                      selected: isSelected,
                                      title: Text(
                                        item?.fullname! ?? '',
                                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                      ),
                                    ),
                                  );
                                },
                                validator: (GetRetailersData? item) {
                                  if (item == null) {
                                    return 'Retailer is required';
                                  } else {
                                    return null;
                                  }
                                },
                                compareFn: (i, GetRetailersData? s) => i.fullname == s?.fullname,
                                itemAsString: (GetRetailersData u) => u.fullname!,
                                // selectedItem: controller.kycData.Retailer != null
                                //     ? retailersList.firstWhere((element) => element.id == controller.kycData.Retailer)
                                //     : null,
                                onChanged: (GetRetailersData? data) {
                                  print('object::::::::::::::::::: ${data!.id}');

                                  print('distributor::::::::::::::::::: ${jsonEncode(data.distributor)}');
                                  controller.retailerData = data;
                                  controller.productTypeData = MiniProductTypeData();
                                  controller.indentItemsDetails = GetIndentItemsDetails();
                                  controller.update();
                                },
                              ),
                              Container(
                                height: 20,
                              ),
                              CommonComponents.defaultTextField(
                                context,
                                title: 'Distributor',
                                enable: false,
                                controller: TextEditingController(
                                    text:
                                        controller.retailerData.distributor != null ? controller.retailerData.distributor!.fullname ?? 'N/A' : 'N/A'),
                                readOnly: true,
                              ),
                              Container(
                                height: 20,
                              ),
                              CommonComponents.defaultDropdownSearch<MiniProductTypeData>(
                                context,
                                title: "Product Type",
                                hintText: "Select",
                                // prefixIcon: const Icon(
                                //   Icons.pin_drop_outlined,
                                //   size: 20,
                                // ),
                                // items: retailersList,
                                asyncItems: (String? filter) async {
                                  await miniController.getMiniProductTypeList();
                                  return miniController.miniProductTypeList;
                                },
                                itemBuilder: (context, MiniProductTypeData? item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected
                                        ? null
                                        : BoxDecoration(
                                            // border: Border.all(color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                          ),
                                    child: ListTile(
                                      selected: isSelected,
                                      title: Text(
                                        item?.name! ?? '',
                                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                      ),
                                    ),
                                  );
                                },
                                validator: (MiniProductTypeData? item) {
                                  if (item == null) {
                                    return 'Product Type is required';
                                  } else {
                                    return null;
                                  }
                                },
                                compareFn: (i, MiniProductTypeData? s) => i.name == s?.name,
                                itemAsString: (MiniProductTypeData u) => u.name!,
                                selectedItem: controller.productTypeData.id != null ? controller.productTypeData : null,
                                onChanged: (MiniProductTypeData? data) {
                                  print('object::::::::::::::::::: ${data!.id}');
                                  controller.productTypeData = data;

                                  controller.getIndentItemsDetails(controller.retailerData.id, controller.productTypeData.id);
                                },
                              ),
                              Container(
                                height: 20,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Products',
                              //       style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w500),
                              //     ),
                              //     Container(
                              //       width: 100,
                              //       height: 30,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(2.0),
                              //       ),
                              //       child: OutlinedButton(
                              //         style: OutlinedButton.styleFrom(
                              //           minimumSize: const Size(100, 30),
                              //           padding: const EdgeInsets.symmetric(horizontal: 16),
                              //           side: BorderSide(
                              //             width: 1.0,
                              //             color: Theme.of(context).colorScheme.primary,
                              //           ),
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(15),
                              //           ),
                              //         ),
                              //         child: Row(
                              //           children: [
                              //             const Icon(
                              //               Icons.add,
                              //             ),
                              //             Text(
                              //               'Add',
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.w600,
                              //                 fontSize: 16,
                              //                 color: Theme.of(context).colorScheme.primary,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         onPressed: () {
                              //           if (formKey.currentState!.validate()) {
                              //             Get.bottomSheet(const AddProductToReceiptBottomSheet(),
                              //                 elevation: 10.0, enableDrag: false, isScrollControlled: true, isDismissible: true);
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Container(
                              //   height: 20,
                              // ),
                              controller.indentItemsDetails.items != null
                                  ? Flexible(
                                      fit: FlexFit.loose,
                                      child: controller.indentItemsDetails.items!.isNotEmpty
                                          ? ListView.builder(
                                              // physics: const NeverScrollableScrollPhysics(),
                                              itemCount: controller.indentItemsDetails.items!.length,
                                              shrinkWrap: true,
                                              itemBuilder: (BuildContext context, int index) {
                                                return CommonReceiptProductsCard(
                                                  index: index,
                                                  productName: controller.indentItemsDetails.items![index].productName!.name ?? 'N/A',
                                                  productPrice: controller.indentItemsDetails.items![index].price != null
                                                      ? controller.indentItemsDetails.items![index].price!.toStringAsFixed(2)
                                                      : 'N/A',
                                                  productQuantity: controller.indentItemsDetails.items![index].totalQuantity != null
                                                      ? controller.indentItemsDetails.items![index].totalQuantity!.toStringAsFixed(0)
                                                      : 'N/A',
                                                  isReceipts: true, productUnits: controller.indentItemsDetails.items![index].unit!.name ?? 'N/A',
                                                  // editBtnLink: () {},
                                                  // deleteBtnLink: () {
                                                  //   // controller.itemList.removeAt(index);
                                                  //   // controller.update();
                                                  //   // print('object removed');
                                                  // },
                                                );
                                              },
                                            )
                                          : const Center(child: Text("No products available for this product type")),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ))),
              Positioned(
                  bottom: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.addReceipt();
                              }
                            },
                            child: const Center(
                                child: Text("Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )))),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
