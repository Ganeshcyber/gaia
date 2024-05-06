import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vaama_dairy_mobile/Helpers/theme_config.dart';

class GradientContainer extends StatefulWidget {
  final Widget child;
  final double? height;
  final double? width;

  const GradientContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });
  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  MyTheme currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          // center: Alignment.center,
          // radius: 1.8,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary,
                ]
              : [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary,
                ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
    );
  }
}

class CommonSecondaryContainer extends StatefulWidget {
  final Widget child;

  const CommonSecondaryContainer({
    super.key,
    required this.child,
  });
  @override
  State<CommonSecondaryContainer> createState() => _CommonSecondaryContainerState();
}

class _CommonSecondaryContainerState extends State<CommonSecondaryContainer> {
  MyTheme currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 248, 251), borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.child,
      ),
    );
  }
}
