import 'dart:io';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Cart%20Model/item_model.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';

class CommonCartCard extends StatefulWidget {
  final String productName;
  final String productId;
  final String productPrice;
  final String productQuantity;
  final String? productImage;
  final VoidCallback cancleBtnLink;
  final VoidCallback btnLink;
  final int? index;

  const CommonCartCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productImage,
    required this.cancleBtnLink,
    required this.btnLink,
    required this.productId,
    this.index,
  }) : super(key: key);

  @override
  State<CommonCartCard> createState() => _CommonCartCard();
}

class _CommonCartCard extends State<CommonCartCard> {
  final controller = Get.put(CartController());
  final miniController = Get.put(MiniController());
  final FocusNode _focusNode = FocusNode();

  late String quantity;
  // late String productId;
  // late String productId;
  // late String productId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = '';
    // widget.initProducts();
    // getCartData();
    // getItemData();
  }

  // late Box box = Hive.box('productsBox');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.btnLink,
      child: Card(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.productName,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 10,
                              ),
                              ExpandTapWidget(
                                onTap: widget.cancleBtnLink,
                                tapPadding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          CommonComponents.defaultDropdownSearch<MiniUnitsData>(
                            context,
                            title: "",
                            hintText: "Select Size",
                            // prefixIcon: const Icon(
                            //   Icons.pin_drop_outlined,
                            //   size: 20,
                            // ),
                            items: miniController.miniUnitsList,
                            // asyncItems: (String? filter) async {
                            //   await miniController.getMiniUnitsList();
                            //   return miniController.miniUnitsList;
                            // },
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
                            selectedItem: controller.cartItems.isNotEmpty
                                ? miniController.miniUnitsList.firstWhere((element) => element.id == controller.cartItems[widget.index!].unitsId)
                                : null,
                            onChanged: (MiniUnitsData? data) async {
                              controller.cartItems[widget.index!].units = double.parse(data!.units!);
                              controller.cartItems[widget.index!].unitsId = data.id!;
                              controller.cartItems[widget.index!].unitsName = data.name!;
                              if (controller.cartItems.any((element) => element.productId == widget.productId)) {
                                controller.updateCart(CartItem(
                                    productId: controller.cartItems[widget.index!].productId,
                                    name: controller.cartItems[widget.index!].name,
                                    price: controller.cartItems[widget.index!].price,
                                    image: controller.cartItems[widget.index!].image,
                                    quantity: controller.cartItems[widget.index!].quantity,
                                    units: controller.cartItems[widget.index!].units,
                                    unitsId: controller.cartItems[widget.index!].unitsId,
                                    unitsName: controller.cartItems[widget.index!].unitsName));
                              }
                            },
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.productPrice,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 10,
                              ),
                              Flexible(
                                child: CommonComponents.defaultTextField(
                                  context,
                                  hintText: 'Enter Qty',
                                  controller: TextEditingController(
                                      text: controller.cartItems.any((element) => element.productId == widget.productId)
                                          ? controller.cartItems[widget.index!].quantity.toString()
                                          : quantity),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                  focusNode: Platform.isIOS ? _focusNode : null,
                                  onFieldSubmitted: (String val) async {
                                    if (controller.cartItems.any((element) => element.productId == widget.productId)) {
                                      setState(() {
                                        if (val.isNotEmpty) {
                                          controller.cartItems[widget.index!].quantity = int.parse(val);
                                          print('updated quantity is ${controller.cartItems[widget.index!].quantity}');
                                          controller.updateCart(CartItem(
                                              id: controller.cartItems[widget.index!].id,
                                              productId: controller.cartItems[widget.index!].productId,
                                              name: controller.cartItems[widget.index!].name,
                                              price: controller.cartItems[widget.index!].price,
                                              image: controller.cartItems[widget.index!].image,
                                              quantity: controller.cartItems[widget.index!].quantity,
                                              units: controller.cartItems[widget.index!].units,
                                              unitsId: controller.cartItems[widget.index!].unitsId,
                                              unitsName: controller.cartItems[widget.index!].unitsName));
                                        }
                                      });
                                    }
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
      ),
    );
  }
}
