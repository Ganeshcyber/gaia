import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Model/get_indents_details.dart';
import 'package:vaama_dairy_mobile/Screens/Indents/Model/get_indents_list.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class IndentsRepo {
  Future<GetIndentsList?> getIndentsList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/orders/retailer/indentslist/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetIndentsList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  getIndentsDetails(id) async {
    try {
      var response = await HttpUtils.getInstance().get("/orders/retailer/indentsdetail/$id");

      if (response.statusCode == 200) {
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
