import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Model/get_indents_details.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class CartRepo {
  createOrder(data) async {
    try {
      var response = await HttpUtils.getInstance().post("/orders/retailer/indentslist/", data: data);
      print('object ${response.data}');

      if (response.statusCode == 201) {
        print('object ${response.data}');
        return GetIndentsDetails.fromJson(response.data as Map<String, dynamic>);
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
