import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool isSelected;

  const CheckBoxWidget({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 18,
      width: 18,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Theme.of(context).colorScheme.surface),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5)),
      child: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.surface, size: 12) : const Offstage(),
    );
  }
}
