import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailer_details.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class RetailersRepo {
  Future<GetRetailersList?> getRetailersList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/users/retailers/minilist/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetRetailersList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  getRetailersDetails(id) async {
    try {
      var response = await HttpUtils.getInstance().get("/users/retailer/details/$id/");
      print('object  retailer details ${response.data}');

      if (response.statusCode == 200) {
        return GetRetailersDetails.fromJson(response.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
  }

  addRetailer(data) async {
    try {
      var response = await HttpUtils.getInstance().post("/users/retailer/create/", data: data);
      print('object ${response.data}');

      if (response.statusCode == 200) {
        print('object ${response.data}');
        return GetRetailersDetails.fromJson(response.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
  }
}
