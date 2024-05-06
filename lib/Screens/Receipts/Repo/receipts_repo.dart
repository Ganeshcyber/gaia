import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_indent_items.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_receipts_details.dart';
import 'package:vaama_dairy_mobile/Screens/Receipts/Model/get_receipts_list.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class ReceiptsRepo {
  Future<GetReceiptsList?> getReceiptsList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/orders/receipts/list/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetReceiptsList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  getReceiptsDetails(id) async {
    try {
      var response = await HttpUtils.getInstance().get("/orders/receipts/$id");
      print('object ${response.data}');

      if (response.statusCode == 200) {
        return GetReceiptsDetails.fromJson(response.data as Map<String, dynamic>);
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

  getIndentItemsDetails(retaillerId, productTypeId) async {
    try {
      print('object::::::::::::::::::: $retaillerId,$productTypeId');

      var response = await HttpUtils.getInstance().get("/orders/itemreceipts/list/$retaillerId/$productTypeId/");
      print('object ${response.data}');

      if (response.statusCode == 200) {
        return GetIndentItemsDetails.fromJson(response.data as Map<String, dynamic>);
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

  addReceipts(data) async {
    try {
      var response = await HttpUtils.getInstance().post("/orders/receipts/list/", data: data);
      print('object ${response.data}');

      if (response.statusCode == 200) {
        print('object ${response.data}');
        return GetReceiptsDetails.fromJson(response.data as Map<String, dynamic>);
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
