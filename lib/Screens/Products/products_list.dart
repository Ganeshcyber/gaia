import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_products_card.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_common_model.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  State<ProductsListView> createState() => _ProductsListView();
}

class _ProductsListView extends State<ProductsListView> {
  final controller = Get.put(ProductsController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final List<MiniCommonModel> filterList = [
    MiniCommonModel(id: '0', name: "None"),
    MiniCommonModel(id: '1', name: "By Name: A-Z"),
    MiniCommonModel(id: '2', name: "By Name: Z-A"),
    MiniCommonModel(id: '3', name: "By Price: Low to High"),
    MiniCommonModel(id: '4', name: "By Price: High to Low"),
  ];
  // int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      initState: (_) => ProductsController.to.initProductsState(),
      builder: (value) => Scaffold(
        appBar: CustomAppBar(
          titleChild: Text(controller.catName),
          leadingChild: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
          leadingLink: () {
            Get.back();
          },
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.productsList.length} items',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.surface),
                          icon: const Row(
                            children: [
                              Text('Sort By'),
                              Icon(
                                Icons.keyboard_arrow_down,
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          items: filterList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(item.name!),
                              onTap: () {
                                print('sort type ${item.id}');
                                if (item.id == '0') {
                                  controller.sortType = 'name';
                                } else if (item.id == '1') {
                                  controller.sortType = 'name';
                                } else if (item.id == '2') {
                                  controller.sortType = '-name';
                                } else if (item.id == '3') {
                                  controller.sortType = 'price';
                                } else {
                                  controller.sortType = '-price';
                                }
                                controller.productsIsRefresh = true;
                                controller.getProductsList();

                                // controller.status = item.id;
                                // controller.getDashboardDataByDepartment();
                                // controller.update();
                              },
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            controller.sortType = '';
                          },
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Obx(() => (SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        // closeLoadingDialog();
                        controller.productsIsRefresh = true;
                        controller.productsCurrentPage = 1;
                        final result = await controller.getProductsList(
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
                        if (controller.productsTotalPages > 1) {
                          final result = await controller.getProductsList(
                            isLoading: false,
                          );
                          if (result) {
                            if (controller.productsCurrentPage > controller.productsTotalPages) {
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
                      child: controller.productsList.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.productsList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                  child: CommonProductsCard(
                                    productId: controller.productsList[index].id ?? '',
                                    productImage: controller.productsList[index].image ?? '',
                                    productName: controller.productsList[index].name ?? '',
                                    productPrice: controller.productsList[index].price ?? '',
                                    index: index,
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("No products available for this category")),
                    ))))
          ]),
        ),
      ),
    );
  }
}
