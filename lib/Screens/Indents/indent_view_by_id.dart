import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_receipt_product_card.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/gradient_container_widgets.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Controller/indent_controller.dart';

class IndentViewById extends StatefulWidget {
  const IndentViewById({Key? key}) : super(key: key);

  @override
  State<IndentViewById> createState() => _IndentViewById();
}

class _IndentViewById extends State<IndentViewById> {
  final controller = Get.put(IndentController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(
      // initState: (_) => IndentController.to.initCategoriesState(),
      builder: (value) => Scaffold(
        appBar: CustomAppBar(
          titleChild: const Text('Indent Summary'),
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
                                (controller.indentsDetails.retailer != null ? controller.indentsDetails.retailer!.fullname ?? 'N/A' : 'N/A')
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
                                Text("Indent ID",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text(controller.indentsDetails.code ?? 'N/A',
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
                                Text("Indent On",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text(
                                    controller.indentsDetails.date != null
                                        ? DateFormat('MMM dd yyyy  hh:mm a').format(controller.indentsDetails.date!)
                                        : 'N/A',
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
                                Text("Status",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.surface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Text(controller.indentsDetails.indentStatusName ?? 'N/A',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
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
                                Text("₹ ${controller.indentsDetails.total ?? 'N/A'}",
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
                                Text("-₹ ${controller.indentsDetails.discountAmount ?? 'N/A'}",
                                    style: const TextStyle(
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
                                Text("₹ ${controller.indentsDetails.taxAmount ?? 'N/A'}",
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
                                Text("₹ ${controller.indentsDetails.total ?? 'N/A'}",
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
                      Container(
                        height: 20,
                      ),
                      Card(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset('assets/images/basket.svg'),
                                        )),
                                    Container(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.indentsDetails.noOfItems ?? 'N/A'} Items ',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                                        ),
                                        Text(
                                          'Delivery On: ${controller.indentsDetails.deliveryDate != null ? DateFormat('MMM dd yyyy').format(controller.indentsDetails.deliveryDate!) : 'N/A'}',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: ListView.builder(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.indentsDetails.retailerOrderItems!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return CommonReceiptProductsCard(
                                        productName: '${controller.indentsDetails.retailerOrderItems![index].product!.name}',
                                        productPrice: double.parse(controller.indentsDetails.retailerOrderItems![index].price!).toStringAsFixed(2),
                                        productQuantity:
                                            '${controller.indentsDetails.retailerOrderItems![index].quantity} (${controller.indentsDetails.retailerOrderItems![index].unit!.name})',
                                        isReceipts: false,
                                        productUnits: controller.indentsDetails.retailerOrderItems![index].unit!.name ?? 'N/A',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
