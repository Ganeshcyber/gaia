import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_indents_card.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Controller/receipts_controller.dart';

class ReceiptsListView extends StatefulWidget {
  const ReceiptsListView({Key? key}) : super(key: key);

  @override
  State<ReceiptsListView> createState() => _ReceiptsListView();
}

class _ReceiptsListView extends State<ReceiptsListView> {
  final controller = Get.put(ReceiptController());
  final miniController = Get.put(MiniController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
        initState: (_) => ReceiptController.to.initState(),
        builder: (value) => SafeArea(
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ALL RETAILERS',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            ExpandTapWidget(
                              onTap: () {
                                Get.toNamed(Routes.receiptFiltersView);
                              },
                              tapPadding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.tune,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectedProductTypeIndex(miniController.miniProductTypeList[0]);
                                    },
                                    child: Container(
                                        // height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            border: Border.all(
                                                color: miniController.miniProductTypeList[0].id == controller.productTypeData.id
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.transparent,
                                                width: 1.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset('assets/images/milk.svg'),
                                              Container(
                                                height: 10,
                                              ),
                                              Text(
                                                (miniController.miniProductTypeList[0].name ?? 'N/A').toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectedProductTypeIndex(miniController.miniProductTypeList[1]);
                                    },
                                    child: Container(
                                        // height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            border: Border.all(
                                                color: miniController.miniProductTypeList[1].id == controller.productTypeData.id
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Colors.transparent,
                                                width: 1.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset('assets/images/byProducts.svg'),
                                              Container(
                                                height: 10,
                                              ),
                                              Text(
                                                (miniController.miniProductTypeList[1].name ?? 'N/A').toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Obx(() => (SmartRefresher(
                          controller: refreshController,
                          enablePullUp: true,
                          onRefresh: () async {
                            // closeLoadingDialog();
                            controller.receiptsIsRefresh = true;
                            controller.receiptsCurrentPage = 1;
                            final result = await controller.getReceiptsList(
                              isLoading: false,
                            );
                            if (result) {
                              refreshController.resetNoData();
                              refreshController.refreshCompleted();
                            } else {
                              refreshController.refreshFailed();
                            }
                          },
                          onLoading: () async {
                            if (controller.receiptsTotalPages > 1) {
                              final result = await controller.getReceiptsList(
                                isLoading: false,
                              );
                              if (result) {
                                if (controller.receiptsCurrentPage > controller.receiptsTotalPages) {
                                  refreshController.loadNoData();
                                } else {
                                  refreshController.loadComplete();
                                }
                              } else {
                                refreshController.loadNoData();
                              }
                            } else {
                              refreshController.loadNoData();
                            }
                          },
                          child: controller.receiptsList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: controller.receiptsList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                      child: CommonIndentCard(
                                        code: controller.receiptsList[index].code ?? 'N/A',
                                        // date: controller.receiptsList[index].createdOn != null
                                        //     ? DateFormat('MMM dd yyyy  hh:mm a').format(controller.receiptsList[index].createdOn!)
                                        //     : 'N/A',
                                        date: controller.receiptsList[index].createdOn != null ? controller.receiptsList[index].createdOn! : 'N/A',
                                        price: controller.receiptsList[index].total ?? 'N/A',
                                        quantity: '${controller.receiptsList[index].noOfItems ?? 'N/A'}',
                                        status: '',
                                        btnLink: () {
                                          controller.getReceiptsDetails(controller.receiptsList[index].id);
                                          // Get.toNamed(Routes.indentViewById);
                                        },
                                        statusColor: Theme.of(context).colorScheme.primary,
                                        isIndent: false,
                                      ),
                                    );
                                  },
                                )
                              : const Center(child: Text("No receipts available for this category")),
                        ))))
              ]),
            ));
  }
}
