import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';

class IndentPlacedSuccessView extends StatefulWidget {
  const IndentPlacedSuccessView({Key? key}) : super(key: key);

  @override
  State<IndentPlacedSuccessView> createState() => _IndentPlacedSuccessView();
}

class _IndentPlacedSuccessView extends State<IndentPlacedSuccessView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
            child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 90,
              ),
              SvgPicture.asset('assets/images/success.svg'),
              Container(
                height: 20,
              ),
              const Text("Successful!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  )),
              Container(
                height: 20,
              ),
              const Text("Your order has been successfully placed Your Order ID is ORD113336.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              Container(
                height: 50,
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                elevation: 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Get.toNamed(Routes.homeView);
                },
                child: Text("Back to Shop",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ]),
          ),
        ])),
      ),
    );
  }
}
