import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class RetailersListView extends StatefulWidget {
  const RetailersListView({Key? key}) : super(key: key);

  @override
  State<RetailersListView> createState() => _RetailersListViewState();
}

class _RetailersListViewState extends State<RetailersListView> {
  final controller = Get.put(RetailersController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            appBar: CustomAppBar(
              titleChild: const Text('Retailers'),
              leadingChild: const Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 36,
              ),
              leadingLink: () {
                Get.back();
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add),
              onPressed: () {
                Get.toNamed(Routes.addRetailersForm);
              },
            ),
            body: GetBuilder<RetailersController>(
                initState: (_) => RetailersController.to.initSelectRetailersState(),
                builder: (value) => SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                          ),
                          Expanded(
                              child: Obx(() => (SmartRefresher(
                                    controller: refreshController,
                                    enablePullUp: true,
                                    onRefresh: () async {
                                      // closeLoadingDialog();
                                      controller.retailersIsRefresh = true;
                                      controller.retailersCurrentPage = 1;
                                      final result = await controller.getRetailersList(
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
                                      if (controller.retailersTotalPages > 1) {
                                        final result = await controller.getRetailersList(
                                          isLoading: false,
                                        );
                                        if (result) {
                                          if (controller.retailersCurrentPage > controller.retailersTotalPages) {
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
                                    child: controller.retailersList.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: controller.retailersList.length,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(left: 16, right: 16),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.getRetailersDetails(controller.retailersList[index].id, from: 'retailers');
                                                  // Get.toNamed(Routes.retailersViewById);
                                                },
                                                child: Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: SvgPicture.asset('assets/images/store.svg'),
                                                                  )),
                                                              Container(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      controller.retailersList[index].fullname != null
                                                                          ? controller.retailersList[index].fullname!.toUpperCase()
                                                                          : 'N/A',
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Theme.of(context).colorScheme.surface),
                                                                    ),
                                                                    Text(
                                                                      controller.retailersList[index].phone != null
                                                                          ? controller.retailersList[index].phone!
                                                                          : 'N/A',
                                                                      style: TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Theme.of(context).colorScheme.surface),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 10,
                                                        ),
                                                        Icon(
                                                          Icons.keyboard_arrow_right_outlined,
                                                          color: Theme.of(context).colorScheme.onSurface,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : const Center(child: Text("No products available for this category")),
                                  )))),
                          // Container(height: 50),
                        ],
                      ),
                    ))));
  }
}
