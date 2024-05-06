import 'package:flutter/material.dart';

class DoneWidget extends StatefulWidget {
  const DoneWidget({Key? key}) : super(key: key);

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Done',
          // gradientType: GradientType.radial,
          // colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.secondaryContainer],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
