import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/Controller/cart_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Login/Controller/login_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(), permanent: true);
    Get.put<RetailersController>(RetailersController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);
  }
}
