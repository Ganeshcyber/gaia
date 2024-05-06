import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_indents_card.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Controller/indent_controller.dart';

class IndentsListView extends StatefulWidget {
  const IndentsListView({Key? key}) : super(key: key);

  @override
  State<IndentsListView> createState() => _IndentsListView();
}

class _IndentsListView extends State<IndentsListView> {
  final controller = Get.put(IndentController());
  final miniController = Get.put(MiniController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(
      initState: (_) => IndentController.to.initState(),
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
                          Get.toNamed(Routes.indentFiltersView);
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
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
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
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
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
                      controller.indentsIsRefresh = true;
                      controller.indentsCurrentPage = 1;
                      final result = await controller.getIndentsList(isLoading: false);
                      if (result) {
                        refreshController.resetNoData();
                        refreshController.refreshCompleted();
                      } else {
                        refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {
                      if (controller.indentsTotalPages > 1) {
                        final result = await controller.getIndentsList(
                          isLoading: false,
                        );
                        if (result) {
                          if (controller.indentsCurrentPage > controller.indentsTotalPages) {
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
                    child: controller.indentsList.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.indentsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                child: CommonIndentCard(
                                  code: controller.indentsList[index].code ?? 'N/A',
                                  date: controller.indentsList[index].date != null
                                      ? DateFormat('MMM dd yyyy').format(controller.indentsList[index].date!)
                                      : 'N/A',
                                  price: controller.indentsList[index].total ?? 'N/A',
                                  quantity: '${controller.indentsList[index].noOfItems ?? 'N/A'}',
                                  status: controller.indentsList[index].indentStatusName ?? 'N/A',
                                  btnLink: () {
                                    controller.getIndentsDetails(controller.indentsList[index].id);
                                    // Get.toNamed(Routes.indentViewById);
                                  },
                                  statusColor: Theme.of(context).colorScheme.primary,
                                  isIndent: true,
                                ),
                              );
                            },
                          )
                        : const Center(child: Text("No indents available for this category")),
                  ))))
        ]),
      ),
    );
  }
}
