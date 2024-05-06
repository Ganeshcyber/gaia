// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
// import 'package:vaama_dairy_mobile/Common%20Widgets/common_done_btn_widget.dart';
// import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
// import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
// import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
// import 'package:vaama_dairy_mobile/Screens/Receipts/Controller/receipts_controller.dart';
// import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_indent_items.dart';

// class AddProductToReceiptBottomSheet extends StatefulWidget {
//   const AddProductToReceiptBottomSheet({super.key});

//   @override
//   State<AddProductToReceiptBottomSheet> createState() => _AddProductToReceiptBottomSheetState();
// }

// class _AddProductToReceiptBottomSheetState extends State<AddProductToReceiptBottomSheet> {
//   final FocusNode _focusNode = FocusNode();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final controller = Get.put(ReceiptController());
//   final productsController = Get.put(ProductsController());
//   final miniController = Get.put(MiniController());

//   double baseUnit = 1.00;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReceiptController>(
//         // initState: (_) => ReceiptController.to.initSignUpState(),
//         builder: (value) => SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               physics: const ClampingScrollPhysics(),
//               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Wrap(
//                 children: [
//                   Stack(children: [
//                     KeyboardActions(
//                       tapOutsideBehavior: TapOutsideBehavior.none,
//                       disableScroll: true,
//                       config: KeyboardActionsConfig(
//                           keyboardBarColor: Theme.of(context).colorScheme.secondary,
//                           nextFocus: false,
//                           defaultDoneWidget: const DoneWidget(),
//                           actions: [KeyboardActionsItem(focusNode: _focusNode)]),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).colorScheme.secondary,
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(25),
//                                 topRight: Radius.circular(25),
//                               ),
//                             ),
//                             child: Form(
//                                 key: formKey,
//                                 // autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Add Product',
//                                         style: TextStyle(
//                                           fontSize: 28,
//                                           fontWeight: FontWeight.w600,
//                                           color: Theme.of(context).colorScheme.surface,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 20),
//                                       CommonComponents.defaultDropdownSearch<IndentItemsList>(
//                                         context,
//                                         title: "Product",
//                                         hintText: "Select Product",
//                                         // prefixIcon: const Icon(
//                                         //   Icons.pin_drop_outlined,
//                                         //   size: 20,
//                                         // ),
//                                         items: controller.indentItemsDetails.items,
//                                         // asyncItems: (String? filter) async {
//                                         //   await productsController.getProductsList();
//                                         //   return productsController.productsList;
//                                         // },
//                                         itemBuilder: (context, IndentItemsList? item, isSelected) {
//                                           return Container(
//                                             margin: const EdgeInsets.symmetric(horizontal: 8),
//                                             decoration: !isSelected
//                                                 ? null
//                                                 : BoxDecoration(
//                                                     // border: Border.all(color: Theme.of(context).primaryColor),
//                                                     borderRadius: BorderRadius.circular(5),
//                                                     color: Theme.of(context).colorScheme.secondaryContainer,
//                                                   ),
//                                             child: ListTile(
//                                               selected: isSelected,
//                                               title: Text(
//                                                 item?.productName!.name ?? '',
//                                                 style: TextStyle(color: Theme.of(context).colorScheme.surface),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         validator: (IndentItemsList? item) {
//                                           if (item == null) {
//                                             return 'Product is required';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         compareFn: (i, IndentItemsList? s) => i.productName.name == s?.productName!.name,
//                                         itemAsString: (IndentItemsList u) => u.productName!.name.toString(),
//                                         // selectedItem: controller.kycData.Retailer != null
//                                         //     ? retailersList.firstWhere((element) => element.id == controller.kycData.Retailer)
//                                         //     : null,
//                                         onChanged: (IndentItemsList? data) {
//                                           controller.indentItemsList = data;
//                                           controller.quantityTF.text = controller.indentItemsList.totalQuantity != null
//                                               ? controller.indentItemsList.totalQuantity!.toStringAsFixed(2)
//                                               : '';
//                                           controller.priceTF.text =
//                                               controller.indentItemsList.price != null ? controller.indentItemsList.price!.toStringAsFixed(2) : '';
//                                           controller.totalPriceTF.text = controller.indentItemsList.totalQuantity != null
//                                               ? controller.indentItemsList.price != null
//                                                   ? (controller.indentItemsList.totalQuantity! * controller.indentItemsList.price!).toStringAsFixed(2)
//                                                   : controller.indentItemsList.totalQuantity!.toStringAsFixed(2)
//                                               : '0.00';
//                                           print('onChange ${controller.totalPriceTF.text}');
//                                           controller.update();
//                                         },
//                                       ),
//                                       // const SizedBox(height: 20),
//                                       // CommonComponents.defaultDropdownSearch<IndentItemsList>(
//                                       //   context,
//                                       //   title: "Category",
//                                       //   hintText: "Select Category",
//                                       //   // prefixIcon: const Icon(
//                                       //   //   Icons.pin_drop_outlined,
//                                       //   //   size: 20,
//                                       //   // ),
//                                       //   items: controller.indentItemsDetails.items,
//                                       //   // asyncItems: (String? filter) async {
//                                       //   //   await productsController.getCategoriesList();
//                                       //   //   return productsController.categoriesList;
//                                       //   // },
//                                       //   itemBuilder: (context, IndentItemsList? item, isSelected) {
//                                       //     return Container(
//                                       //       margin: const EdgeInsets.symmetric(horizontal: 8),
//                                       //       decoration: !isSelected
//                                       //           ? null
//                                       //           : BoxDecoration(
//                                       //               // border: Border.all(color: Theme.of(context).primaryColor),
//                                       //               borderRadius: BorderRadius.circular(5),
//                                       //               color: Theme.of(context).colorScheme.secondaryContainer,
//                                       //             ),
//                                       //       child: ListTile(
//                                       //         selected: isSelected,
//                                       //         title: Text(
//                                       //           item?.productType! ?? '',
//                                       //           style: TextStyle(color: Theme.of(context).colorScheme.surface),
//                                       //         ),
//                                       //       ),
//                                       //     );
//                                       //   },
//                                       //   validator: (IndentItemsList? item) {
//                                       //     if (item == null) {
//                                       //       return 'Category is required';
//                                       //     } else {
//                                       //       return null;
//                                       //     }
//                                       //   },
//                                       //   compareFn: (i, IndentItemsList? s) => i.productType == s?.productType,
//                                       //   itemAsString: (IndentItemsList u) => u.productType!,
//                                       //   selectedItem: controller.indentItemsList.productType != null
//                                       //       ? controller.indentItemsDetails.items!
//                                       //           .firstWhere((element) => element.productType == controller.indentItemsList.productType)
//                                       //       : null,
//                                       //   onChanged: (IndentItemsList? data) {},
//                                       // ),
//                                       const SizedBox(height: 20),
//                                       CommonComponents.defaultDropdownSearch<MiniUnitsData>(
//                                         context,
//                                         title: "Size",
//                                         hintText: "Select",
//                                         asyncItems: (String? filter) async {
//                                           await miniController.getMiniUnitsList();
//                                           return miniController.miniUnitsList;
//                                         },
//                                         itemBuilder: (context, MiniUnitsData? item, isSelected) {
//                                           return Container(
//                                             margin: const EdgeInsets.symmetric(horizontal: 8),
//                                             decoration: !isSelected
//                                                 ? null
//                                                 : BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(5),
//                                                     color: Theme.of(context).colorScheme.secondaryContainer,
//                                                   ),
//                                             child: ListTile(
//                                               selected: isSelected,
//                                               title: Text(
//                                                 item?.name! ?? '',
//                                                 style: TextStyle(color: Theme.of(context).colorScheme.surface),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         validator: (MiniUnitsData? item) {
//                                           if (item == null) {
//                                             return 'Size is required';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         compareFn: (i, MiniUnitsData? s) => i.name == s?.name,
//                                         itemAsString: (MiniUnitsData u) => u.name!,
//                                         onChanged: (MiniUnitsData? data) {
//                                           controller.indentItemsList.unit = data!;
//                                           baseUnit = double.parse(data.units!);

//                                           controller.totalPriceTF.text = controller.indentItemsList.totalQuantity != null
//                                               ? controller.indentItemsList.price != null
//                                                   ? (controller.indentItemsList.totalQuantity! * controller.indentItemsList.price! * baseUnit)
//                                                       .toStringAsFixed(2)
//                                                   : controller.indentItemsList.totalQuantity!.toStringAsFixed(2)
//                                               : '0.00';
//                                           print('onChange ${controller.totalPriceTF.text}');

//                                           controller.update();
//                                         },
//                                       ),
//                                       const SizedBox(height: 20),
//                                       CommonComponents.defaultTextField(
//                                         context,
//                                         title: 'Quantity',
//                                         hintText: 'Enter Quantity',
//                                         controller: controller.quantityTF,
//                                         focusNode: Platform.isIOS ? _focusNode : null,
//                                         textInputAction: TextInputAction.done,
//                                         keyboardType: TextInputType.number,
//                                         inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
//                                         validator: (String? val) {
//                                           if (val == '') {
//                                             return 'Quantity is required';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         onChange: (val) {
//                                           if (val.isNotEmpty) {
//                                             controller.indentItemsList.totalQuantity = double.parse(val);
//                                             controller.totalPriceTF.text = controller.indentItemsList.totalQuantity != null
//                                                 ? controller.indentItemsList.price != null
//                                                     ? (controller.indentItemsList.totalQuantity! * controller.indentItemsList.price! * baseUnit)
//                                                         .toStringAsFixed(2)
//                                                     : controller.indentItemsList.totalQuantity!.toStringAsFixed(2)
//                                                 : '0.00';
//                                             controller.update();
//                                           }
//                                         },
//                                       ),

//                                       const SizedBox(height: 20),
//                                       CommonComponents.defaultTextField(
//                                         context,
//                                         title: 'Price',
//                                         hintText: 'Enter Price',
//                                         readOnly: true,
//                                         enable: false,
//                                         controller: controller.priceTF,
//                                       ),
//                                       const SizedBox(height: 20),
//                                       CommonComponents.defaultTextField(
//                                         context,
//                                         title: 'Total Amount',
//                                         hintText: 'Enter Total Amount',
//                                         readOnly: true,
//                                         enable: false,
//                                         controller: controller.totalPriceTF,
//                                       ),
//                                       const SizedBox(height: 120),
//                                     ],
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0.0,
//                       child: Container(
//                         color: Theme.of(context).colorScheme.secondary,
//                         width: MediaQuery.of(context).size.width,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: MaterialButton(
//                             minWidth: MediaQuery.of(context).size.width,
//                             height: 50,
//                             elevation: 0.0,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             color: Theme.of(context).colorScheme.primary,
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 Get.back();
//                                 controller.itemList.add(controller.indentItemsList);
//                                 print('object ${jsonEncode(controller.itemList)}');
//                                 controller.update();
//                               }
//                             },
//                             child: const Center(
//                               child: Text(
//                                 "Add",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ],
//               ),
//             ));
//   }
// }
