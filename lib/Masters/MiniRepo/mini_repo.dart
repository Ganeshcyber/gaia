import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_areas_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_cities_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_locations_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_states_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_zones_list.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class MiniRepo {
  Future<MiniProductTypeList?> getMiniProductTypeList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/producttype/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniProductTypeList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniUnitsList?> getMiniUnitsList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/unit/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniUnitsList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniStatesList?> getMiniStatesList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/states/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniStatesList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniCitiesList?> getMiniCitiesList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/citys/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniCitiesList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniZonesList?> getMiniZonesList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/zone/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniZonesList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniLocationsList?> getMiniLocationsList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/location/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniLocationsList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<MiniAreasList?> getMiniAreasList(filterParams) async {
    try {
      var response = await HttpUtils.getInstance().get("/masters/area/mini/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return MiniAreasList.fromJson(response.data as Map<String, dynamic>);
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
