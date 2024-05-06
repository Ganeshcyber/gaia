import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Cart%20Model/item_model.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';

class CommonProductsCard extends StatefulWidget {
  final String productName;
  final String productId;
  final String productPrice;
  final String? productImage;
  final int? index;

  const CommonProductsCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productId,
    this.index,
    // required this.quantity,
  }) : super(key: key);

  @override
  State<CommonProductsCard> createState() => _CommonProductsCard();
}

class _CommonProductsCard extends State<CommonProductsCard> {
  final controller = Get.put(CartController());
  final miniController = Get.put(MiniController());

  final FocusNode _focusNode = FocusNode();
  MiniUnitsData units = MiniUnitsData();

  late String quantity;

  late String productUnitPrice;

  @override
  void initState() {
    super.initState();
    quantity = '';
    productUnitPrice = '0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Row(
              children: [
                widget.productImage == null || widget.productImage == ''
                    ? const SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.broken_image,
                          size: (25),
                        ),
                      )
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          widget.productImage!,
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
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/pieacePrice.svg'),
                              Container(
                                width: 5,
                              ),
                              Text(
                                '₹ ${widget.productPrice}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/totalPrice.svg'),
                              Container(
                                width: 5,
                              ),
                              Text(
                                // ignore: unnecessary_brace_in_string_interps
                                '₹ ${productUnitPrice}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      CommonComponents.defaultDropdownSearch<MiniUnitsData>(
                        context,
                        title: "",
                        hintText: "Select Size",
                        items: miniController.miniUnitsList,
                        // asyncItems: (String? filter) async {
                        //   await miniController.getMiniUnitsList();
                        //   return miniController.miniUnitsList;
                        // },
                        enabled: controller.cartItems.any((element) => element.productId == widget.productId) ? false : true,
                        itemBuilder: (context, MiniUnitsData? item, isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                  ),
                            child: ListTile(
                              selected: isSelected,
                              title: Text(
                                item?.name! ?? '',
                                style: TextStyle(color: Theme.of(context).colorScheme.surface),
                              ),
                            ),
                          );
                        },
                        compareFn: (i, MiniUnitsData? s) => i.name == s?.name,
                        itemAsString: (MiniUnitsData u) => u.name!,
                        selectedItem: controller.cartItems.any((element) => element.productId == widget.productId)
                            ? miniController.miniUnitsList.firstWhere((element) =>
                                element.id ==
                                controller
                                    .cartItems[controller.cartItems
                                        .indexOf(controller.cartItems.firstWhere((element) => element.productId == widget.productId))]
                                    .unitsId)
                            : null,
                        onChanged: (MiniUnitsData? data) async {
                          units = data!;
                          setState(() {
                            if (quantity != '') {
                              productUnitPrice = '${double.parse(units.units!) * double.parse(widget.productPrice) * int.parse(quantity)}';
                            } else {
                              productUnitPrice = '${double.parse(widget.productPrice) * double.parse(units.units!)}';
                            }
                          });
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CommonComponents.defaultTextField(
                              context,
                              hintText: 'Enter Qty',
                              enable: controller.cartItems.any((element) => element.productId == widget.productId) ? false : true,
                              controller: TextEditingController(
                                  text: controller.cartItems.any((element) => element.productId == widget.productId)
                                      ? controller
                                          .cartItems[controller.cartItems
                                              .indexOf(controller.cartItems.firstWhere((element) => element.productId == widget.productId))]
                                          .quantity
                                          .toString()
                                      : quantity.toString()),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                              focusNode: Platform.isIOS ? _focusNode : null,
                              onFieldSubmitted: (String val) {
                                setState(() {
                                  if (val.isNotEmpty) {
                                    if (units.id != null) {
                                      productUnitPrice = '${double.parse(units.units!) * double.parse(widget.productPrice) * int.parse(val)}';
                                    } else {
                                      productUnitPrice = '${double.parse(widget.productPrice) * int.parse(val)}';
                                    }
                                  } else {
                                    productUnitPrice = '${double.parse(widget.productPrice) * double.parse(units.units!)}';
                                  }
                                });
                              },
                              onChange: (String val) async {
                                if (val.isNotEmpty) {
                                  quantity = val;
                                } else {
                                  quantity = '';
                                }
                              },
                            ),
                          ),
                          Container(
                            width: 10,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                print('index value is ${widget.index}');

                                if (controller.cartItems.any((element) => element.productId == widget.productId)) {
                                  Get.toNamed(Routes.myCartView);
                                } else {
                                  controller.addToCart(
                                    CartItem(
                                        productId: widget.productId,
                                        name: widget.productName,
                                        price: double.parse(widget.productPrice),
                                        image: widget.productImage!,
                                        quantity: int.parse(quantity),
                                        units: double.parse(units.units!),
                                        unitsId: units.id!,
                                        unitsName: units.name!),
                                  );
                                  controller.fetchCartItems();
                                  controller.update();
                                }
                              },
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer, width: 3),
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 14,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      Text(
                                        controller.cartItems.any((element) => element.productId == widget.productId) ? 'Go to cart' : 'Add to cart',
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
