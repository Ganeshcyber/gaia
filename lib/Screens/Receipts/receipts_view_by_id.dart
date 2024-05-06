import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_receipt_product_card.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/gradient_container_widgets.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Controller/receipts_controller.dart';

class ReceiptsViewById extends StatefulWidget {
  const ReceiptsViewById({Key? key}) : super(key: key);

  @override
  State<ReceiptsViewById> createState() => _ReceiptsViewById();
}

class _ReceiptsViewById extends State<ReceiptsViewById> {
  final controller = Get.put(ReceiptController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      // initState: (_) => ReceiptController.to.initCategoriesState(),
      builder: (value) => Scaffold(
        appBar: CustomAppBar(
          titleChild: Text('#${controller.receiptsDetails.code ?? 'N/A'}'),
          leadingChild: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
          leadingLink: () {
            Get.back();
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 20,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      CommonSecondaryContainer(
                        child: Row(
                          children: [
                            Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset('assets/images/store.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                (controller.receiptsDetails.retailer != null
                                        ? '${controller.receiptsDetails.retailer!.fullname ?? 'N/A'} - ${controller.receiptsDetails.retailer!.location != null ? controller.receiptsDetails.retailer!.location!.name ?? 'N/A' : 'N/A'}'
                                        : 'N/A')
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      CommonSecondaryContainer(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Receipt ID",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text(controller.receiptsDetails.code ?? 'N/A',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Receipt On",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text(controller.receiptsDetails.createdOn != null ? controller.receiptsDetails.createdOn! : 'N/A',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            // Container(
                            //   height: 5,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Status",
                            //         style: TextStyle(
                            //           color: Theme.of(context).colorScheme.surface,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.normal,
                            //         )),
                            //     Text("Pending",
                            //         style: TextStyle(
                            //           color: Theme.of(context).colorScheme.primary,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w500,
                            //         )),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      CommonSecondaryContainer(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text("₹ ${controller.receiptsDetails.total ?? 'N/A'}",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Savings",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text("-₹ ${controller.receiptsDetails.discountAmount ?? 'N/A'}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tax",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text("₹ ${controller.receiptsDetails.taxAmount ?? 'N/A'}",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Price",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text("₹ ${controller.receiptsDetails.total ?? 'N/A'}",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 20,
                      // ),
                      // CommonSecondaryContainer(
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Addons",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.onSurface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.normal,
                      //               )),
                      //           Text("12 Items",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.onSurface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.normal,
                      //               )),
                      //         ],
                      //       ),
                      //       Container(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Gaia Cow Milk (200g)",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.normal,
                      //               )),
                      //           Text("10",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w500,
                      //               )),
                      //         ],
                      //       ),
                      //       Container(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Gaia Muskmelon Dahi Bucket (15kg)  ",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.normal,
                      //               )),
                      //           Text("1",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w500,
                      //               )),
                      //         ],
                      //       ),
                      //       Container(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Gaia Muskmelon Dahi Pouch ",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.normal,
                      //               )),
                      //           Text("1",
                      //               style: TextStyle(
                      //                 color: Theme.of(context).colorScheme.surface,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w500,
                      //               )),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: 20,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                      child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/images/basket.svg'))),
                                  Container(
                                    width: 10,
                                  ),
                                  Text(
                                    '${controller.receiptsDetails.noOfItems ?? 'N/A'} Items ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                                  ),
                                ],
                              ),
                              Container(
                                height: 10,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.receiptsDetails.receiptItems!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return CommonReceiptProductsCard(
                                      productName: '${controller.receiptsDetails.receiptItems![index].product!.name}',
                                      productPrice: double.parse(controller.receiptsDetails.receiptItems![index].price!).toStringAsFixed(2),
                                      productQuantity: controller.receiptsDetails.receiptItems![index].receivedQty ?? 'N/A',
                                      // productQuantity:
                                      //     '${controller.receiptsDetails.receiptItems![index].quantity} (${controller.receiptsDetails.receiptItems![index].unit!.name})',
                                      isReceipts: false,
                                      productUnits: controller.indentItemsDetails.items![index].unit!.name ?? 'N/A',
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
