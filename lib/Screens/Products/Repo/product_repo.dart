import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Model/get_categories_list.dart';
import 'package:vaama_dairy_mobile/Screens/Products/Model/get_products_list.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class ProductsRepo {
  Future<GetCategoriesList?> getCategoriesList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/category/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetCategoriesList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<GetProductsList?> getProductsList(catId, retailerId, filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/products/$catId/$retailerId/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetProductsList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }
}
