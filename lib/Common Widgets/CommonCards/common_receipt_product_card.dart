import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Controller/receipts_controller.dart';

class CommonReceiptProductsCard extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String productUnits;
  final String? productImage;
  final VoidCallback? editBtnLink;
  final VoidCallback? deleteBtnLink;
  final bool isReceipts;
  final int? index;

  const CommonReceiptProductsCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    this.productImage,
    this.editBtnLink,
    this.deleteBtnLink,
    required this.isReceipts,
    required this.productUnits,
    this.index,
  }) : super(key: key);

  @override
  State<CommonReceiptProductsCard> createState() => _CommonReceiptProductsCardState();
}

class _CommonReceiptProductsCardState extends State<CommonReceiptProductsCard> {
  final FocusNode _focusNode = FocusNode();
  final controller = Get.put(ReceiptController());
  late String quantity;

  @override
  void initState() {
    super.initState();
    quantity = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              widget.productImage == null || widget.productImage == ''
                  ? const SizedBox(
                      height: 65,
                      width: 65,
                      child: Icon(
                        Icons.broken_image,
                        size: (25),
                      ),
                    )
                  : SizedBox(
                      height: 65,
                      width: 65,
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
                      )),
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
                        Text(
                          widget.productName,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        // Visibility(
                        //   visible: isReceipts == true,
                        //   child: Row(
                        //     children: [
                        //       ExpandTapWidget(
                        //           tapPadding: const EdgeInsets.all(10),
                        //           onTap: isReceipts == true ? editBtnLink! : () {},
                        //           child: SvgPicture.asset('assets/images/edit.svg')),
                        //       Container(
                        //         width: 20,
                        //       ),
                        //       ExpandTapWidget(
                        //           tapPadding: const EdgeInsets.all(10),
                        //           onTap: isReceipts == true ? deleteBtnLink! : () {},
                        //           child: SvgPicture.asset('assets/images/close.svg'))
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Qty: ${widget.productQuantity} (${widget.productUnits})',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        widget.isReceipts == true
                            ? Flexible(
                                child: CommonComponents.defaultTextField(
                                context,
                                hintText: 'Received Qty',
                                controller: TextEditingController(text: quantity.toString()),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                focusNode: Platform.isIOS ? _focusNode : null,
                                onFieldSubmitted: (String val) {
                                  setState(() {
                                    if (val.isNotEmpty) {
                                      controller.indentItemsDetails.items![widget.index!].totalQuantity = double.parse(val);
                                    } else {
                                      controller.indentItemsDetails.items![widget.index!].totalQuantity = 0.0;
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
                              ))
                            : Flexible(
                                child: Text(
                                  '₹ ${widget.productPrice}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
