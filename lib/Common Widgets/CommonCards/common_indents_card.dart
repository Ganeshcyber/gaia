import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonIndentCard extends StatelessWidget {
  final String code;
  final String date;
  final String price;
  final String quantity;
  final String status;
  final Color statusColor;
  final VoidCallback btnLink;
  final bool isIndent;

  const CommonIndentCard({
    Key? key,
    required this.code,
    required this.date,
    required this.price,
    required this.quantity,
    required this.status,
    required this.btnLink,
    required this.statusColor,
    required this.isIndent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnLink,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/images/basket.svg'),
                            )),
                        Container(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isIndent == true ? 'Indent ID: $code' : 'Receipt ID: $code',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                              ),
                              Text(
                                isIndent == true ? 'Indent On: $date' : 'Receipt On: $date',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right_outlined)
                      ],
                    ),
                  ),
                ],
              ),
              isIndent == true
                  ? Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Price ($quantity Items)',
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              '₹ $price',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              Container(
                height: 10,
              ),
              const Divider(
                thickness: 0.1,
                height: 0.5,
              ),
              isIndent == true
                  ? Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Status',
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              status,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: statusColor),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Price ($quantity Items)',
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              '₹ $price',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
