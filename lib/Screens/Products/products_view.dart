import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Alert%20Dailog/retailer_changed_alert_dailog.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_snackbar_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final controller = Get.put(ProductsController());
  final retailersController = Get.put(RetailersController());
  final miniController = Get.put(MiniController());
  final cartController = Get.put(CartController());

  CarouselController buttonCarouselController = CarouselController();
  final RefreshController refreshController = RefreshController(initialRefresh: false);

  final List<String> images = [
    'https://media.licdn.com/dms/image/C561BAQE56HXm_aygYQ/company-background_10000/0/1621600155878/gaiadairy_cover?e=2147483647&v=beta&t=g1ilF6ngEXYpLWRfXyhri526ImjadsUl4cfNCOBD4S8',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7o64j5QXd0CJCly3UWWhEo9bgef4o-NXs0A&usqp=CAU',
    'https://media.licdn.com/dms/image/D4D22AQE3GFOhl7B8mA/feedshare-shrink_800/0/1708415601320?e=2147483647&v=beta&t=Ynfq53ptEkDRKcdVCDBVFGXY1kqteXwdhcPKwIAI4m4',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
        initState: (_) => ProductsController.to.initState(),
        builder: (value) => SafeArea(
                child: Stack(children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      CommonComponents.defaultDropdownSearch<GetRetailersData>(
                        context,
                        title: "",
                        hintText: "Select Retailer",
                        // filledColor: Colors.transparent,
                        items: retailersController.retailersList,
                        // asyncItems: (String? filter) async {
                        //   await retailersController.getRetailersList();
                        //   return retailersController.retailersList;
                        // },
                        itemBuilder: (context, GetRetailersData? item, isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Theme.of(context).colorScheme.secondaryContainer,
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
                        selectedItem: retailersController.retailersList.any((element) => element.id == CommonService.instance.retailerId)
                            ? retailersController.retailersList.firstWhere((element) => element.id == CommonService.instance.retailerId)
                            : null,
                        onChanged: (GetRetailersData? data) {
                          print('object ${data!.id}');
                          if (cartController.cartItems.isNotEmpty) {
                            if (CommonService.instance.retailerId != data.id) {
                              Get.dialog(RetailerChangedAlertDialog(
                                newStr: data.fullname!,
                                oldStr: CommonService.instance.retailerName,
                                retailerData: data,
                                from: 'retailer',
                              ));
                            }
                          } else {
                            retailersController.getRetailersDetails(data.id, from: 'home');
                            CommonService.instance.retailerName = data.fullname!;
                            CommonService.instance.retailerId = data.id!;

                            SessionManager.setRetailerName(data.fullname ?? '');
                            SessionManager.setRetailerId(data.id ?? '');
                          }

                          // controller.retailerData = data;
                        },
                      ),
                      // Container(
                      //   height: 10,
                      // ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200, // Adjust the height as needed
                          viewportFraction: 1.0, // Set this to 1.0 for full-width
                          enlargeCenterPage: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        items: images.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network(
                                image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: images.map((imageUrl) {
                          int index = images.indexOf(imageUrl);
                          return currentIndex == index
                              ? Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).colorScheme.primaryContainer,
                                          border: Border.all(color: Theme.of(context).colorScheme.secondary)),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
                                  ),
                                );
                        }).toList(),
                      ),
                      Container(
                        height: 10,
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
                                              style:
                                                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
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
                                              style:
                                                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
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
                      Container(
                        height: 20,
                      ),
                      Expanded(
                          child: Obx(() => (SmartRefresher(
                                controller: refreshController,
                                enablePullUp: true,
                                onRefresh: () async {
                                  // closeLoadingDialog();
                                  controller.categoriesIsRefresh = true;
                                  controller.categoriesCurrentPage = 1;
                                  final result = await controller.getCategoriesList(
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
                                  if (controller.categoriesTotalPages > 1) {
                                    final result = await controller.getCategoriesList(
                                      isLoading: false,
                                    );
                                    if (result) {
                                      if (controller.categoriesCurrentPage > controller.categoriesTotalPages) {
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
                                child: controller.categoriesList.isNotEmpty
                                    ? GridView.builder(
                                        itemCount: controller.categoriesList.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(left: 16, right: 16),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2, childAspectRatio: 1, mainAxisSpacing: 10, crossAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (retailersController.retailersDetails.id != null && controller.productTypeData.id != null) {
                                                controller.catId = controller.categoriesList[index].id;
                                                controller.catName = controller.categoriesList[index].name;
                                                await Get.toNamed(Routes.productsListView);
                                              } else {
                                                showSnackBar(
                                                  title: "Oops..!",
                                                  message: 'Please select both retailer and product type to continue',
                                                  icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
                                                );
                                              }
                                            },
                                            child: Card(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    controller.categoriesList[index].image == null || controller.categoriesList[index].image == ''
                                                        ? const SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.image_not_supported,
                                                                size: (40),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 100,
                                                            width: 100,
                                                            child: Image.network(
                                                              controller.categoriesList[index].image!,
                                                              height: double.infinity,
                                                              width: double.infinity,
                                                              alignment: Alignment.center,
                                                              fit: BoxFit.fill,
                                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                                if (loadingProgress == null) {
                                                                  return child;
                                                                }
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes != null
                                                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                );
                                                              },
                                                              errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
                                                                return const Center(
                                                                  child: Icon(
                                                                    Icons.broken_image,
                                                                    size: (25),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                    Text(
                                                      controller.categoriesList[index].name!.toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : const Center(child: Text("No categories available for this retailer")),
                              ))))
                    ]),
                  ),
                ),
              ),
            ])));
  }
}
