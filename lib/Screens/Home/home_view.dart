import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Dashboard/dashboard_view.dart';
import 'package:vaama_dairy_mobile/Screens/Home/Controller/home_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/indents_list.dart';
import 'package:vaama_dairy_mobile/Screens/Products/products_view.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/profile_view.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/receipts_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, this.filterBtnLink}) : super(key: key);
  final VoidCallback? filterBtnLink;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  var commonService = CommonService.instance;
  final args = Get.arguments;

  final List widgetOptions = [
    {"screen": const DashboardView(), "title": "Dashboard"},
    {"screen": const ProductsView(), "title": "Products"},
    {"screen": const IndentsListView(), "title": "Indents"},
    {"screen": const ReceiptsListView(), "title": "Receipts"},
    {"screen": const ProfileView(), "title": "Profile"}
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: CustomAppBar(
            titleChild: Text(
              widgetOptions[controller.pageIndex.value]["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actionsWidget: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/cart.svg",
                ),
                onPressed: () {
                  Get.toNamed(Routes.myCartView);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/notifications.svg",
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: PopScope(
              canPop: false,
              child: GetBuilder<HomeController>(
                initState: (_) => HomeController.to.initState(),
                builder: (value) => Obx(() => widgetOptions[controller.pageIndex.value]["screen"]),
              )),
          bottomNavigationBar: Obx(() => BottomAppBar(
                height: 80,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.secondary,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpandTapWidget(
                      onTap: () {
                        controller.onchangeIndex(0);
                      },
                      tapPadding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 28,
                            width: 58,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: controller.pageIndex.value != 0 ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(
                                controller.pageIndex.value == 0 ? "assets/Bottom_nav_bar_images/home.svg" : "assets/Bottom_nav_bar_images/home.svg",
                              ),
                            ),
                          ),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: controller.pageIndex.value != 0
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    ),
                    ExpandTapWidget(
                        onTap: () {
                          controller.onchangeIndex(1);
                        },
                        tapPadding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 28,
                                width: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: controller.pageIndex.value != 1 ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer),
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SvgPicture.asset(
                                      controller.pageIndex.value == 1
                                          ? "assets/Bottom_nav_bar_images/products_blue.svg"
                                          : "assets/Bottom_nav_bar_images/products.svg",
                                    ))),
                            Text(
                              'Products',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: controller.pageIndex.value != 1
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.primary),
                            )
                          ],
                        )),
                    ExpandTapWidget(
                        onTap: () {
                          controller.onchangeIndex(2);
                        },
                        tapPadding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 28,
                                width: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: controller.pageIndex.value != 2 ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer),
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SvgPicture.asset(
                                      controller.pageIndex.value == 2
                                          ? "assets/Bottom_nav_bar_images/indents_blue.svg"
                                          : "assets/Bottom_nav_bar_images/indents.svg",
                                    ))),
                            Text(
                              'Indents',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: controller.pageIndex.value != 2
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.primary),
                            )
                          ],
                        )),
                    ExpandTapWidget(
                        onTap: () {
                          controller.onchangeIndex(3);
                        },
                        tapPadding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 28,
                                width: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: controller.pageIndex.value != 3 ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer),
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SvgPicture.asset(
                                      controller.pageIndex.value == 3
                                          ? "assets/Bottom_nav_bar_images/receipts_blue.svg"
                                          : "assets/Bottom_nav_bar_images/receipts.svg",
                                    ))),
                            Text(
                              'Receipts',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: controller.pageIndex.value != 3
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.primary),
                            )
                          ],
                        )),
                    ExpandTapWidget(
                        onTap: () {
                          controller.onchangeIndex(4);
                        },
                        tapPadding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 28,
                                width: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: controller.pageIndex.value != 4 ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer),
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: SvgPicture.asset(
                                      controller.pageIndex.value == 4
                                          ? "assets/Bottom_nav_bar_images/user_profile_blue.svg"
                                          : "assets/Bottom_nav_bar_images/user_profile.svg",
                                    ))),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: controller.pageIndex.value != 4
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context).colorScheme.primary),
                            )
                          ],
                        ))
                  ],
                ),
                // initialActiveIndex: 2,
                // onTap: (int index) {
                //   controller.onchangeIndex(index);
                // },
              )),
          floatingActionButton: controller.pageIndex.value == 3
              ? GestureDetector(
                  onTap: () {
                    print('add receipt view');
                    Get.toNamed(Routes.addReceiptView);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              : Container(),
        ));
  }
}
