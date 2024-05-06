import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vaama_dairy_mobile/Helpers/theme_config.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static MyTheme get currentTheme => GetIt.I<MyTheme>();
  static ThemeMode get themeMode => GetIt.I<MyTheme>().currentTheme();

  static ThemeData lightTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: false,
      primaryColor: currentTheme.currentColor(),
      dividerColor: const Color.fromRGBO(0, 31, 59, 1),
      fontFamily: 'Montserrat',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: currentTheme.currentColor(),
            // backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: 018,
            )),
      ),
      // bottomSheetTheme: const BottomSheetThemeData(
      //   backgroundColor: Colors.white,
      // ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.getColor('AppColor', 100),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5.0)),
        border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5.0)),
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        suffixIconColor: currentTheme.currentColor(),
        prefixIconColor: currentTheme.currentColor(),
        filled: true,
        fillColor: const Color.fromRGBO(244, 251, 255, 1),
      ),

      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        // clipBehavior: Clip.antiAlias,
        elevation: 5,
        shadowColor: currentTheme.currentColor().withOpacity(0.4),
        // color: const Color.fromRGBO(244, 251, 255, 1),
        margin: const EdgeInsets.only(bottom: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      disabledColor: Colors.grey[600],
      brightness: Brightness.light,
      indicatorColor: currentTheme.currentColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(color: currentTheme.currentColor()),
      iconTheme: const IconThemeData(
        // color: Color.fromRGBO(247, 219, 86, 1),
        // opacity: 1.0,
        size: 24.0,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: currentTheme.currentColor(),
          primaryContainer: const Color.fromRGBO(33, 176, 69, 1),
          surface: Colors.black,
          onSurface: const Color.fromRGBO(128, 128, 129, 1),
          brightness: Brightness.light,
          error: const Color.fromRGBO(217, 55, 45, 1),
          secondary: Colors.white,
          secondaryContainer: const Color.fromRGBO(244, 251, 255, 1)),
      hintColor: Colors.grey,
      dialogTheme: DialogTheme(
        elevation: 5,
        // backgroundColor: const Color.fromRGBO(0, 20, 59, 1),
        titleTextStyle: TextStyle(fontSize: 18, color: currentTheme.currentColor(), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Theme.of(context).colorScheme.primary,
        labelPadding: const EdgeInsets.only(left: 50, right: 50),
        unselectedLabelColor: Colors.blueGrey,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(247, 219, 86, 1)),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blueGrey),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: const Color.fromRGBO(247, 219, 86, 1),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 50.0),
      appBarTheme: AppBarTheme(
        // surfaceTintColor: Colors.transparent,
        backgroundColor: currentTheme.currentColor(),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        // foregroundColor: Colors.white
      ),
    );
  }

  static ThemeData darkTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: currentTheme.currentColor(),
      primaryColor: currentTheme.currentColor(),
      dividerColor: const Color.fromRGBO(0, 31, 59, 1),
      fontFamily: 'Montserrat',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: currentTheme.currentColor(),
            // backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: 018,
            )),
      ),
      // bottomSheetTheme: const BottomSheetThemeData(
      //   backgroundColor: Colors.white,
      // ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: currentTheme.currentColor(),
        cursorColor: currentTheme.currentColor(),
        selectionColor: currentTheme.getColor('AppColor', 100),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid, width: 10, color: Color.fromRGBO(1, 39, 73, 1)),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid, width: 10, color: Color.fromRGBO(1, 39, 73, 1)),
            borderRadius: BorderRadius.circular(5.0)),
        border: UnderlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.solid, width: 10, color: Color.fromRGBO(1, 39, 73, 1)),
            borderRadius: BorderRadius.circular(5.0)),
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        suffixIconColor: currentTheme.currentColor(),
        prefixIconColor: currentTheme.currentColor(),
        filled: true,
        fillColor: const Color.fromRGBO(0, 31, 59, 1),
      ),

      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: currentTheme.currentColor(),
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        color: currentTheme.currentColor(),
        margin: const EdgeInsets.only(bottom: 5.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(
              color: Color.fromRGBO(0, 41, 85, 0.4),
            )),
      ),
      disabledColor: Colors.grey[600],
      brightness: Brightness.light,
      indicatorColor: currentTheme.currentColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(color: currentTheme.currentColor()),
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(247, 219, 86, 1),
        opacity: 1.0,
        size: 24.0,
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: currentTheme.currentColor(),
          surface: Colors.white,
          primaryContainer: const Color.fromRGBO(0, 20, 59, 1),
          brightness: Brightness.light,
          error: const Color.fromRGBO(217, 55, 45, 1),
          secondary: const Color.fromRGBO(131, 91, 3, 1),
          secondaryContainer: const Color.fromRGBO(175, 133, 31, 1)),
      hintColor: Colors.grey,
      dialogTheme: DialogTheme(
        elevation: 5,
        backgroundColor: const Color.fromRGBO(0, 20, 59, 1),
        titleTextStyle: TextStyle(fontSize: 18, color: currentTheme.currentColor(), fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Theme.of(context).colorScheme.primary,
        labelPadding: const EdgeInsets.only(left: 50, right: 50),
        unselectedLabelColor: Colors.blueGrey,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(247, 219, 86, 1)),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blueGrey),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: const Color.fromRGBO(247, 219, 86, 1),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 50.0),
      appBarTheme: AppBarTheme(
        // surfaceTintColor: Colors.transparent,
        backgroundColor: currentTheme.currentColor(),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        // foregroundColor: Colors.white
      ),
    );
  }
}
