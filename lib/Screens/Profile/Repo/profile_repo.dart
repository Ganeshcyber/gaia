import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Model/get_profile_details.dart';
import 'package:vaama_dairy_mobile/Utills/http_utills.dart';

class ProfileRepo {
  Future<bool> userLogout(String? refresh, String? deviceId, String? deviceType) async {
    debugPrint("Printing refresh: $refresh");
    debugPrint("Printing access: ${CommonService.instance.accessToken}");
    var refreshObj = jsonEncode({'refresh': refresh, 'device_uuid': deviceId, 'device_type': deviceType == 'android' ? 1 : 2});
    debugPrint("Printing refresh: $refreshObj");

    try {
      var response = await HttpUtils.getInstance().post("/users/logout/", data: refreshObj);
      debugPrint("response.toString()::::::::::::::::::${response.statusCode}");
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  getProfileDetails() async {
    try {
      var response = await HttpUtils.getInstance().get("/users/iamuser/");
      print('object ${response.data}');

      if (response.statusCode == 200) {
        return GetProfileDetails.fromJson(response.data as Map<String, dynamic>);
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
