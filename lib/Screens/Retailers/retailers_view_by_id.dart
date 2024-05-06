import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Screens/Login/Controller/login_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class RetailersViewById extends StatefulWidget {
  const RetailersViewById({Key? key}) : super(key: key);

  @override
  State<RetailersViewById> createState() => _RetailersViewByIdState();
}

class _RetailersViewByIdState extends State<RetailersViewById> {
  final controller = Get.put(RetailersController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            appBar: CustomAppBar(
              titleChild: const Text('Retailer Details'),
              leadingChild: const Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 36,
              ),
              leadingLink: () {
                Get.back();
              },
            ),
            body: GetBuilder<LoginController>(
                // initState: (_) => LoginController.to.initState(),
                builder: (value) => SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: SvgPicture.asset('assets/images/store.svg'),
                                                  )),
                                              Container(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.retailersDetails.fullname != null
                                                      ? controller.retailersDetails.fullname!.toUpperCase()
                                                      : 'N/A',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'GST No',
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                              Container(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                controller.retailersDetails.gstNo ?? 'N/A',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Mobile No',
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                              Container(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                controller.retailersDetails.phone ?? 'N/A',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Alternate No',
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                              Text(
                                                controller.retailersDetails.alternatePhone ?? 'N/A',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Email',
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.retailersDetails.email ?? 'N/A',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sale Agent',
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.retailersDetails.salesagent != null
                                                      ? controller.retailersDetails.salesagent!.fullname ?? 'N/A'
                                                      : 'N/A',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Billing Address',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.retailersDetails.defaultBillingAddress != null
                                                ? '${controller.retailersDetails.defaultBillingAddress!.dNo ?? 'N/A'}, ${controller.retailersDetails.defaultBillingAddress!.landmark ?? 'N/A'}, ${controller.retailersDetails.defaultBillingAddress!.area != null ? controller.retailersDetails.defaultBillingAddress!.area!.name ?? 'N/A' : 'N/A'}, ${controller.retailersDetails.defaultBillingAddress!.city != null ? controller.retailersDetails.defaultBillingAddress!.city!.name ?? 'N/A' : 'N/A'}, ${controller.retailersDetails.defaultBillingAddress!.state != null ? controller.retailersDetails.defaultBillingAddress!.state!.name ?? 'N/A' : 'N/A'} ${controller.retailersDetails.defaultBillingAddress!.pincode ?? 'N/A'}'
                                                : 'N/A',
                                            style:
                                                TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shipping Address',
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Text(
                                            controller.retailersDetails.defaultShippingAddress != null
                                                ? '${controller.retailersDetails.defaultShippingAddress!.dNo ?? 'N/A'}, ${controller.retailersDetails.defaultShippingAddress!.landmark ?? 'N/A'}, ${controller.retailersDetails.defaultShippingAddress!.area != null ? controller.retailersDetails.defaultShippingAddress!.area!.name ?? 'N/A' : 'N/A'}, ${controller.retailersDetails.defaultShippingAddress!.city != null ? controller.retailersDetails.defaultShippingAddress!.city!.name ?? 'N/A' : 'N/A'}, ${controller.retailersDetails.defaultShippingAddress!.state != null ? controller.retailersDetails.defaultShippingAddress!.state!.name ?? 'N/A' : 'N/A'} ${controller.retailersDetails.defaultShippingAddress!.pincode ?? 'N/A'}'
                                                : 'N/A',
                                            style:
                                                TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Container(height: 50),
                        ],
                      ),
                    ))));
  }
}
