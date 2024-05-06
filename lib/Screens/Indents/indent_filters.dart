import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_common_model.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Controller/indent_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class IndentFiltersView extends StatefulWidget {
  const IndentFiltersView({Key? key}) : super(key: key);

  @override
  State<IndentFiltersView> createState() => _IndentFiltersView();
}

class _IndentFiltersView extends State<IndentFiltersView> {
  final controller = Get.put(IndentController());
  final retailersController = Get.put(RetailersController());

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  bool isExpandedRetailers = false;
  bool isExpandedOrderDates = false;
  bool isExpandedOrderState = false;

  final List<MiniCommonModel> indentStatusList = [
    MiniCommonModel(id: '1', name: "Pending"),
    MiniCommonModel(id: '2', name: "Approved"),
    MiniCommonModel(id: '3', name: "Delivered"),
    MiniCommonModel(id: '4', name: "Rejected"),
  ];

  final List<MiniCommonModel> dateRangeList = [
    MiniCommonModel(id: 'today', name: "Today"),
    MiniCommonModel(id: 'yesterday', name: "Yesterday"),
    MiniCommonModel(id: 'week', name: "Past 7 days"),
    MiniCommonModel(id: 'month', name: "This month"),
    MiniCommonModel(id: 'year', name: "This year"),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(
      initState: (_) => IndentController.to.initFilterState(),
      builder: (value) => Scaffold(
        appBar: CustomAppBar(
          titleChild: const Text('Filters'),
          leadingChild: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
          leadingLink: () {
            Get.back();
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ExpansionTile(
                        shape: Border.all(color: Colors.transparent),
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpandedRetailers = value;
                          });
                        },
                        trailing: Icon(
                          isExpandedRetailers ? Icons.close : Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "Retailers",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                        ),
                        tilePadding: const EdgeInsets.all(0),
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Column(
                              children: [
                                TextFormField(
                                  autofocus: false,
                                  // controller: controller.alumniSearch,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    hintText: "Search ",
                                    prefixIcon: GestureDetector(
                                        onTap: () {
                                          // controller.alumniIsRefresh = true;
                                          // controller.fetchAlumniList(filter: controller.alumniSearch.text);
                                        },
                                        child: const Icon(Icons.search)),
                                  ),
                                  // style: AppConstants.themeStyles.textFiledWithEntry,
                                  onChanged: (String? value) {
                                    // if (value!.isEmpty) {
                                    //   controller.alumniIsRefresh = true;
                                    //   controller.fetchAlumniList(filter: value);
                                    // }
                                  },
                                  onFieldSubmitted: (val) {
                                    // controller.alumniIsRefresh = true;
                                    // controller.fetchAlumniList(filter: val);
                                  },
                                  onSaved: (String? value) {},
                                ),
                                Container(
                                  height: 10,
                                ),
                                Expanded(
                                    child: Obx(() => (SmartRefresher(
                                          controller: refreshController,
                                          enablePullUp: true,
                                          onRefresh: () async {
                                            // closeLoadingDialog();
                                            retailersController.retailersIsRefresh = true;
                                            retailersController.retailersCurrentPage = 1;
                                            final result = await retailersController.getRetailersList(isLoading: false);
                                            if (result) {
                                              refreshController.resetNoData();
                                              refreshController.refreshCompleted();
                                            } else {
                                              refreshController.refreshFailed();
                                            }
                                          },
                                          onLoading: () async {
                                            if (retailersController.retailersTotalPages > 1) {
                                              final result = await retailersController.getRetailersList(isLoading: false);
                                              if (result) {
                                                if (retailersController.retailersCurrentPage > retailersController.retailersTotalPages) {
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
                                          child: retailersController.retailersList.isNotEmpty
                                              ? ListView.builder(
                                                  itemCount: retailersController.retailersList.length,
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          retailersController.retailersList[index].fullname ?? 'N/A',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                              color: Theme.of(context).colorScheme.surface),
                                                        ),
                                                        Radio(
                                                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                            if (states.contains(MaterialState.disabled)) {
                                                              return Theme.of(context).colorScheme.primary;
                                                            }
                                                            return Theme.of(context).colorScheme.primary;
                                                          }),
                                                          value: retailersController.retailersList[index].id,
                                                          groupValue: controller.retailerId,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              // itemId = val;
                                                              controller.retailerId = val;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )
                                              : const Center(child: Text("No products available for this category")),
                                        ))))
                              ],
                            ),
                          )
                        ]),
                    ExpansionTile(
                        shape: Border.all(color: Colors.transparent),
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpandedOrderDates = value;
                          });
                        },
                        trailing: Icon(
                          isExpandedOrderDates ? Icons.close : Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "Indent Date",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                        ),
                        tilePadding: const EdgeInsets.all(0),
                        children: <Widget>[
                          Column(
                            children: [
                              ListView.builder(
                                itemCount: dateRangeList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dateRangeList[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                      ),
                                      Radio(
                                        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                          if (states.contains(MaterialState.disabled)) {
                                            return Theme.of(context).colorScheme.primary;
                                          }
                                          return Theme.of(context).colorScheme.primary;
                                        }),
                                        value: dateRangeList[index].id,
                                        groupValue: controller.dateRangeId,
                                        onChanged: (val) {
                                          setState(() {
                                            // itemId = val;
                                            controller.dateRangeId = val;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ]),
                    ExpansionTile(
                        shape: Border.all(color: Colors.transparent),
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpandedOrderState = value;
                          });
                        },
                        trailing: Icon(
                          isExpandedOrderState ? Icons.close : Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "Indent Status",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                        ),
                        tilePadding: const EdgeInsets.all(0),
                        children: <Widget>[
                          Column(
                            children: [
                              ListView.builder(
                                itemCount: indentStatusList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        indentStatusList[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                      ),
                                      Radio(
                                        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                          if (states.contains(MaterialState.disabled)) {
                                            return Theme.of(context).colorScheme.primary;
                                          }
                                          return Theme.of(context).colorScheme.primary;
                                        }),
                                        value: indentStatusList[index].id,
                                        groupValue: controller.indentStatusId,
                                        onChanged: (val) {
                                          setState(() {
                                            // itemId = val;
                                            controller.indentStatusId = val;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Clear All',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  controller.retailerId = '';
                                  controller.indentStatusId = '';
                                  controller.dateRangeId = '';
                                  controller.indentsIsRefresh = true;
                                  controller.getIndentsList();
                                  controller.update();
                                }),
                          ),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                Get.back();
                                controller.indentsIsRefresh = true;
                                controller.getIndentsList();
                              },
                              child: const Center(
                                  child: Text("Apply",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      )))),
                        ]),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
