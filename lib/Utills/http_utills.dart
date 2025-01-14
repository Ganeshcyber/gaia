// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_snackbar_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import '../routes/app_pages.dart';

// Dev Server
const String API_PREFIX = 'http://vaamadairy.dev.absol.in/';
//
// Testing Server
// const String API_PREFIX = 'http://vaamadairy.testing.absol.in/';

// Staging Server
// const String API_PREFIX = 'http://vaamadairy.staging.absol.in/';

class HttpUtils {
  //  global dio object
  static Dio dio = Dio();

  static Dio dio2 = Dio();

  //Dev Server

  // static const String API_PREFIX = 'http://192.168.1.41:8000/';

  // static const String API_IO_PREFIX = 'http://hpsconnect_io.dev.absol.in/v1';
  // static const String API_IO_SERVER_PREFIX = 'ws://hpsconnect_io.dev.absol.in/';

  //Live Server
  // static const String API_PREFIX = 'http://hpsconnect.absol.in/';
  // static const String API_IO_PREFIX = 'http://hpsconnect.absol.in:8000/v1';
  // static const String API_IO_SERVER_PREFIX = 'ws://hpsconnect.absol.in:8000/';

  //Staging Server
  // static const String API_PREFIX = 'http://capsgold.staging.absol.in/';
  // static const String IO_PREFIX = 'ws://192.168.1.42:3000/';

  //Testing Server
  // static const String API_PREFIX = 'http://capsgold.testing.absol.in/';
  // static const String API_IO_PREFIX = 'http://hpsconnect_io.testing.absol.in/v1';
  // static const String API_IO_SERVER_PREFIX = 'ws://hpsconnect_io.testing.absol.in/';

  // static const String API_PREFIX = kReleaseM.ode //Live Server
  //     ? 'http://144.24.97.26:80/'
  //     : kProfileMode //Testing Server
  //         ? 'http://144.24.97.26:8001/'
  //         : 'http://144.24.97.26:85/';

  static const Duration connectTimeOut = Duration(milliseconds: 100000);
  static const Duration receiveTimeOut = Duration(milliseconds: 50000);

  static setToken() {
    dio = Dio();
    getInstance();
  }

  static Dio getInstance() {
    dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer ${CommonService.instance.accessToken}";
    dio.options.baseUrl = API_PREFIX;
    dio.options.connectTimeout = connectTimeOut;
    dio.options.receiveTimeout = receiveTimeOut;
    // dio.options.followRedirects = false;
    // dio.options.validateStatus =  (status) => true;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      debugPrint("request: ${request.path}");
      if (CommonService.instance.accessToken != '') {
        request.headers['Authorization'] = 'Bearer  ${CommonService.instance.accessToken}';
      }
      return handler.next(request); //continue
    }, onResponse: (response, handler) {
      debugPrint("onResponse statusCode  $response");
      // Do something with response data
      return handler.next(response); // continue
    }, onError: (DioException error, handler) async {
      debugPrint("error statusCode  $error");
      if (error.response != null && error.response?.statusCode == 401) {
        try {
          if (CommonService.instance.refreshToken != '') {
            final refreshToken = CommonService.instance.refreshToken;
            debugPrint("refreshToken::::::::::::00000:::::::::::::::::::::::: + $refreshToken");
            dio2 = Dio();
            dio2.options.headers['content-Type'] = 'application/json';
            dio2.options.headers["Authorization"] = "Bearer ${CommonService.instance.accessToken}";
            dio2.options.connectTimeout = connectTimeOut;
            dio2.options.receiveTimeout = receiveTimeOut;
            // dio.options.followRedirects = false;
            // dio.options.validateStatus =  (status) => true;
            debugPrint("Printing Base Url For Refresh Token:$API_PREFIX users/token/refresh/");
            final refreshResponse = await dio2.post("${API_PREFIX}users/token/refresh/", data: {
              "refresh": refreshToken,
              "device_uuid": CommonService.instance.deviceId,
              "device_type": CommonService.instance.deviceType == 'android' ? 1 : 2
            }).then((value) async {
              debugPrint("refreshToken::::::::::::::::::::::::::::::::::::${value.data['access']}");
              if (value.statusCode == 200) {
                debugPrint("printing status code in refresh token: ${value.statusCode}");
                debugPrint("Printing Refreshed Access Token: ${value.data['access']} ");
                // successfully got the new access token
                error.requestOptions.headers["Authorization"] = "Bearer ${value.data['access']}";
                CommonService.instance.accessToken = value.data['access'];
                final opts = Options(method: error.requestOptions.method, headers: error.requestOptions.headers);
                final cloneReq = await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(cloneReq);
              } else {
                CommonService.instance.accessToken = '';
                CommonService.instance.refreshToken = '';
                SessionManager.setAccessToken('');
                SessionManager.setRefreshToken('');
                closeLoadingDialog();
                Get.toNamed(Routes.loginView);
                return handler.reject(error);
              }
            }).catchError((error) {
              closeLoadingDialog();
              CommonService.instance.accessToken = '';
              CommonService.instance.refreshToken = '';
              SessionManager.setAccessToken('');
              SessionManager.setRefreshToken('');
              Get.toNamed(Routes.loginView);
            });
            return refreshResponse;
          }
        } catch (e) {
          return handler.reject(error);
        }
      } else {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        closeLoadingDialog();
        if (error.response != null && error.response!.statusCode == 403) {
          if (error.response != null) {
            String errorMessage = '';

            error.response!.data.forEach((key, value) {
              errorMessage += '$key: $value';
            });
            showSnackBar(
              title: "Forbidden ${error.response!.statusCode}",
              message: errorMessage,
              icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
            );
            // throw errorMessage;
            // throw e.response!.data['message'];
          } else {
            showSnackBar(
              title: "Forbidden ${error.response!.statusCode}",
              message: "Some Thing Went Wrong",
              icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
            );
            // throw "Some Thing Went Wrong";
          }

          handler.reject(error);
        } else if (error.response != null && error.response!.statusCode == 500) {
          showSnackBar(
            title: "Something went wrong. ${error.response!.statusCode}",
            message: "Getting Server Error", //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
          );
          return handler.reject(error);
        } else if (error.response != null && error.response!.statusCode == 502) {
          showSnackBar(
            title: "Bad Gateway ${error.response!.statusCode}",
            message: "We are trying to fix the problem.", //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
          );
          return handler.reject(error);
        } else if (error.response != null && error.response!.statusCode == 502) {
          showSnackBar(
            title: "Something went wrong. ${error.response!.statusCode}",
            message: "We are trying to fix the problem.", //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
          );
          return handler.reject(error);
        } else {
          if (error.response != null) {
            String errorMessage = '';

            error.response!.data.forEach((key, value) {
              errorMessage += '$key: $value';
            });
            showSnackBar(
              title: "Forbidden ${error.response!.statusCode}",
              message: errorMessage,
              icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
            );
            // throw errorMessage;
            // throw e.response!.data['message'];
          } else {
            showSnackBar(
              title: "Forbidden ${error.response!.statusCode}",
              message: "Some Thing Went Wrong",
              icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
            );
            // throw "Some Thing Went Wrong";
          }
          // showSnackBar(
          //   title: "Server..! error",
          //   message: "Getting Server Error \n${error.response == null ? "" : error.response!.data}",
          //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
          // );
          return handler.next(error);
        }

        return handler.next(error);
      }
      //else if (error.response?.statusCode == 404 || error.response?.statusCode == 500) {}
    }));

    return dio;
  }

  static Dio postInstance() {
    dio = Dio();
    dio.options.baseUrl = API_PREFIX;
    dio.options.connectTimeout = connectTimeOut;
    dio.options.receiveTimeout = receiveTimeOut;
    // dio.options.followRedirects = false;
    // dio.options.validateStatus = (status) => true;
    dio.options.headers['content-Type'] = 'application/json';

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }

  // }
}

// class HttpSSEUtils {
//   late String method;
//   late String url;
//   late http.Request request;
//   StreamSubscription? subscription;

//   HttpSSEUtils.get(this.url) {
//     method = 'GET';
//   }

//   listen(Function(dynamic) cb) async {
//     request = http.Request(method, Uri.parse(API_PREFIX + url));
//     request.headers['Cache-Control'] = 'no-cache';
//     request.headers['Accept'] = 'text/event-stream';
//     // Add your authorization header here if needed
//     // request.headers["Authorization"] = "Bearer ${CommonService.instance.accessToken}";
//     var client = http.Client();
//     var response = await client.send(request);
//     subscription = response.stream.transform(utf8.decoder).listen(
//           (String event) {
//             // Split the event into its components
//             var lines = event.split('\n');
//             Map<String, dynamic> eventData = {};

//             // Parse each line of the event
//             for (var line in lines) {
//               var index = line.indexOf(':');
//               if (index == -1) continue;
//               // var field = line.substring(0, index);
//               var value = line.substring(index + 1).trim();
//               // print('live price is $value');
//               // print('live price return type is ${value.runtimeType}');
//               var decodeValue = jsonDecode(value);

//               if (decodeValue['value'].isNotEmpty) {
//                 // print('object');
//                 eventData = decodeValue;
//                 // print('Event data is ${eventData['value']}');
//               }
//             }

//             // Send the parsed JSON data to the callback function
//             // if (eventData['value'] != null) {
//             cb(eventData);
//             // }
//           },
//           cancelOnError: true,
//           onDone: () {
//             // Reconnect on completion
//             listen(cb);
//           },
//           onError: (e) {
//             print('error is $e');
//             // Reconnect on error
//             listen(cb);
//           },
//         );
//   }

//   cancel() {
//     subscription?.cancel();
//   }
// }
