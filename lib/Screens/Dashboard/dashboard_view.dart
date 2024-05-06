import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            'Welcome....!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.secondaryContainer),
          ),
        )
      ]),
    ]));
  }
}
