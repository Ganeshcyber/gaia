import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({super.key});

  @override
  State<NotificationsListView> createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  // final BottomSheetWidget bottomSheetWidget = const BottomSheetWidget();
  // final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleChild: const Text('Notifications'),
        leadingChild: const Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 36,
        ),
        leadingLink: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                // child: Obx(() => (SmartRefresher(
                //       controller: refreshController,
                //       enablePullUp: true,
                //       onRefresh: () async {
                //         controller.isRefresh = true;
                //         controller.currentPage = 1;
                //         final result = await controller.getNotificationsList();
                //         if (result) {
                //           refreshController.resetNoData();
                //           refreshController.refreshCompleted();
                //         } else {
                //           refreshController.refreshFailed();
                //         }
                //       },
                //       onLoading: () async {
                //         if (controller.totalPages > 1) {
                //           final result = await controller.getNotificationsList();
                //           if (result) {
                //             if (controller.currentPage > controller.totalPages) {
                //               refreshController.loadNoData();
                //             } else {
                //               refreshController.loadComplete();
                //             }
                //           } else {
                //             refreshController.loadNoData();
                //           }
                //         } else {
                //           refreshController.loadNoData();
                //         }
                //       },
                child:
                    //  controller.notificationsListCount != 0
                    //     ? ListView.builder(
                    //         // controller: controller.scrollController,
                    //         padding: const EdgeInsets.only(bottom: 100),
                    //         itemCount: 10,
                    //         shrinkWrap: true,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return NotificationsCard(
                    //             btnLink: () {
                    //               // Get.toNamed(Routes.bullionPaymentViewById);
                    //             },
                    //             title: index.isOdd ? 'Transaction Success' : 'Capsgold',
                    //             date: '2min ago',
                    //             description: index.isOdd
                    //                 ? 'We have succesfully received your payment for 100 grams gold'
                    //                 : 'MCX GOLD Down by Rupees 51, GOLD: 58837 ',
                    //           );
                    //         },
                    //       )
                    //     :
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/noNotifications.svg'),
                            Text(
                              'No Notifications Yet',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                            ),
                            const Text(
                              'You have no notifications right now. Come back later',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                            ),
                          ],
                          //   ),
                          // ),
                          // )
                        ))),
          ],
        ),
      ),
    );
  }
}
