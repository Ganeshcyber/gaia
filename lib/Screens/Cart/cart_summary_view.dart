import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Controller/products_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class CartSummaryView extends StatefulWidget {
  const CartSummaryView({Key? key}) : super(key: key);

  @override
  State<CartSummaryView> createState() => _CartSummaryView();
}

class _CartSummaryView extends State<CartSummaryView> with SingleTickerProviderStateMixin {
  final controller = Get.put(CartController());

  final retailersController = Get.put(RetailersController());
  // final RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleChild: const Text('Indent Summary'),
        leadingChild: const Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 36,
        ),
        leadingLink: () {
          Get.back();
        },
      ),
      body: GetBuilder<ProductsController>(
        // initState: (_) => ProductsController.to.initCartItems(),
        builder: (value) => SafeArea(
            child: Stack(children: [
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
                        Card(
                          color: const Color.fromARGB(255, 244, 248, 251),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/store.svg'),
                                    )),
                                Container(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    (retailersController.retailersDetails.fullname ?? 'N/A').toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                                  ),
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
                                    Text("₹ ${controller.totalPrice}",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/basket.svg'),
                                    )),
                                Container(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.cartItems.length} Items ',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface),
                                    ),
                                    Text(
                                      'Delivery On: ${DateFormat('yyyy-MM-dd').format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + 1,
                                      ))}',
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 10,
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.cartItems.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            controller.cartItems[index].image == ''
                                                ? const SizedBox(
                                                    height: 100,
                                                    width: 80,
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: (25),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 100,
                                                    width: 80,
                                                    child: Image.network(
                                                      controller.cartItems[index].image,
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
                                            Container(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.cartItems[index].name,
                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                  ),
                                                  Container(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${controller.cartItems[index].unitsName} x ${controller.cartItems[index].quantity}',
                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      Container(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '₹ ${(controller.cartItems[index].price * controller.cartItems[index].quantity * controller.cartItems[index].units).toStringAsFixed(2)}',
                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 150,
                )
              ]),
            ),
          ),

          Positioned(
            bottom: 0.0,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹ ${controller.totalPrice}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        controller.createOrder();
                        // Get.toNamed(Routes.indentPlacedSuccessView);
                      },
                      child: Text("Proceed",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )
          // : Container()
        ])),
      ),
    );
  }
}
