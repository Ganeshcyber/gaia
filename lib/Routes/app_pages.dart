import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/cart_summary_view.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/cart_view.dart';
import 'package:vaama_dairy_mobile/Screens/Cart/indent_placed_success_view.dart';
import 'package:vaama_dairy_mobile/Screens/Home/home_view.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/indent_filters.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/indent_view_by_id.dart';
import 'package:vaama_dairy_mobile/Screens/Login/login_view.dart';
import 'package:vaama_dairy_mobile/Screens/Notifications/notifications_list.dart';
import 'package:vaama_dairy_mobile/Screens/Products/products_list.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/profile_details_view.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/add_receipts_view.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/receipts_filters.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/receipts_view_by_id.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/retailers_list_view.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/retailers_view_by_id.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/select_retailer_view.dart';

import '../Screens/Retailers/Add Retailers Forms/add_retailers_form.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown

  static final pages = [
    GetPage(name: Routes.loginView, page: () => const LoginView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.homeView, page: () => const HomeView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.selectRetailersView, page: () => const SelectRetailersView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.retailersListView, page: () => const RetailersListView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.retailersViewById, page: () => const RetailersViewById(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.addRetailersForm, page: () => const AddRetailersForm(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.productsListView, page: () => const ProductsListView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.myCartView, page: () => const MyCartView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.cartSummaryView, page: () => const CartSummaryView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.indentPlacedSuccessView, page: () => const IndentPlacedSuccessView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.indentFiltersView, page: () => const IndentFiltersView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.indentViewById, page: () => const IndentViewById(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.receiptsViewById, page: () => const ReceiptsViewById(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.notificationsListView, page: () => const NotificationsListView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.profileDetailsView, page: () => const ProfileDetailsView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.addReceiptView, page: () => const AddReceiptView(), transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: Routes.receiptFiltersView, page: () => const ReceiptFiltersView(), transitionDuration: const Duration(milliseconds: 300)),
  ];
}
