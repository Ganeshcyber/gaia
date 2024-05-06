import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/CommonCards/common_cart_card.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Model/post_indent_items.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({Key? key}) : super(key: key);

  @override
  State<MyCartView> createState() => _MyCartView();
}

class _MyCartView extends State<MyCartView> with SingleTickerProviderStateMixin {
  final controller = Get.put(CartController());
  final retailersController = Get.put(RetailersController());

  // final RefreshController refreshController = RefreshController(initialRefresh: false);
  // int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleChild: const Text('Cart'),
        leadingChild: const Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 36,
        ),
        leadingLink: () {
          Get.back();
        },
      ),
      body: GetBuilder<CartController>(
        initState: (_) => CartController.to.initState(),
        builder: (value) => SafeArea(
          child: controller.cartItems.isNotEmpty
              ? Stack(children: [
                  SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                                    Text(
                                      "${controller.cartItems.length} Item(s) in your cart",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset('assets/images/schemes.svg'),
                                                Container(
                                                  width: 5,
                                                ),
                                                Text("Schemes",
                                                    style: TextStyle(
                                                      color: Theme.of(context).colorScheme.surface,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: const Color.fromARGB(255, 244, 248, 251),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
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
                                                Text("₹ ${controller.totalPrice}",
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
                                                const Text("-₹ 0",
                                                    style: TextStyle(
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
                                                Text("₹ 0",
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
                                                Text("₹ ${controller.totalPrice.toStringAsFixed(2)}",
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
                                    ),
                                    // Card(
                                    //   color: const Color.fromARGB(255, 244, 248, 251),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(16.0),
                                    //     child: Column(
                                    //       children: [
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Text("Addons",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.onSurface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.normal,
                                    //                 )),
                                    //             Text("12 Items",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.onSurface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.normal,
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //         Container(
                                    //           height: 5,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Text("Gaia Cow Milk (200g)",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.normal,
                                    //                 )),
                                    //             Text("10",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.w500,
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //         Container(
                                    //           height: 5,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Text("Gaia Muskmelon Dahi Bucket (15kg)  ",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.normal,
                                    //                 )),
                                    //             Text("1",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.w500,
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //         Container(
                                    //           height: 5,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Text("Gaia Muskmelon Dahi Pouch ",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.normal,
                                    //                 )),
                                    //             Text("1",
                                    //                 style: TextStyle(
                                    //                   color: Theme.of(context).colorScheme.surface,
                                    //                   fontSize: 14,
                                    //                   fontWeight: FontWeight.w500,
                                    //                 )),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Address',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Billing Address',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.surface),
                                                          ),
                                                          Container(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            retailersController.retailersDetails.defaultBillingAddress != null
                                                                ? '${retailersController.retailersDetails.defaultBillingAddress!.dNo ?? 'N/A'}, ${retailersController.retailersDetails.defaultBillingAddress!.landmark ?? 'N/A'}, ${retailersController.retailersDetails.defaultBillingAddress!.area != null ? retailersController.retailersDetails.defaultBillingAddress!.area!.name ?? 'N/A' : 'N/A'}, ${retailersController.retailersDetails.defaultBillingAddress!.city != null ? retailersController.retailersDetails.defaultBillingAddress!.city!.name ?? 'N/A' : 'N/A'}, ${retailersController.retailersDetails.defaultBillingAddress!.state != null ? retailersController.retailersDetails.defaultBillingAddress!.state!.name ?? 'N/A' : 'N/A'} ${retailersController.retailersDetails.defaultBillingAddress!.pincode ?? 'N/A'}'
                                                                : 'N/A',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.normal,
                                                                color: Theme.of(context).colorScheme.surface),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(16),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Shipping Address',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.surface),
                                                          ),
                                                          Container(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            retailersController.retailersDetails.defaultShippingAddress != null
                                                                ? '${retailersController.retailersDetails.defaultShippingAddress!.dNo ?? 'N/A'}, ${retailersController.retailersDetails.defaultShippingAddress!.landmark ?? 'N/A'}, ${retailersController.retailersDetails.defaultShippingAddress!.area != null ? retailersController.retailersDetails.defaultShippingAddress!.area!.name ?? 'N/A' : 'N/A'}, ${retailersController.retailersDetails.defaultShippingAddress!.city != null ? retailersController.retailersDetails.defaultShippingAddress!.city!.name ?? 'N/A' : 'N/A'}, ${retailersController.retailersDetails.defaultShippingAddress!.state != null ? retailersController.retailersDetails.defaultShippingAddress!.state!.name ?? 'N/A' : 'N/A'} ${retailersController.retailersDetails.defaultShippingAddress!.pincode ?? 'N/A'}'
                                                                : 'N/A',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.normal,
                                                                color: Theme.of(context).colorScheme.surface),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        color: const Color.fromARGB(255, 244, 248, 251),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.info_outline,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'View Address',
                                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: controller.cartItems.length,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return CommonCartCard(
                                            productId: controller.cartItems[index].productId ?? '',
                                            btnLink: () {},
                                            cancleBtnLink: () async {
                                              controller.removeFromCart(controller.cartItems[index].id!);
                                              print('cart items list count ${controller.cartItems.length}');
                                              controller.update();
                                            },
                                            productImage: '',
                                            productName: controller.cartItems[index].name,
                                            productPrice:
                                                '₹ ${(controller.cartItems[index].price * controller.cartItems[index].quantity * controller.cartItems[index].units).toStringAsFixed(2)}',
                                            productQuantity: controller.cartItems[index].quantity.toString(),
                                            index: index,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                            )
                          ]))),

                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            int i = 0;
                            for (var element in controller.cartItems) {
                              i++;
                              controller.indentItem.add(RetailerIndentItem(
                                  productId: element.productId,
                                  locationId: retailersController.retailersDetails.location!.id,
                                  unitId: element.unitsId,
                                  quantity: element.quantity.toString(),
                                  requestedQuantity: element.quantity.toString(),
                                  originalQuantity: 0,
                                  freeQuantity: 0,
                                  reqFreeQuantity: 0,
                                  discountPercent: "0.00",
                                  discountAmount: "0.00",
                                  taxPercent: "0.00",
                                  taxAmount: "0.00"));
                              // }

                              // return true;
                              if (i == controller.cartItems.length) {
                                Get.toNamed(Routes.cartSummaryView);
                              }
                            }
                          },
                          child: Text("Continue",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  )
                  // : Container()
                ])
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset(
                      'assets/images/empty_cart.svg',
                    ),
                    Container(
                      height: 20,
                    ),
                    const Text("Your Cart is Empty!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        )),
                    Container(
                      height: 20,
                    ),
                    const Text("Looks like you haven’t added anything to your cart yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ]),
                ),
        ),
      ),
    );
  }
}
