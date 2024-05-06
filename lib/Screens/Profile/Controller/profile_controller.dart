import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_snackbar_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Model/get_profile_details.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Repo/profile_repo.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  var commonService = CommonService.instance;

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfileDetails();
    });
  }

  final _profileDetails = GetProfileDetails().obs;
  GetProfileDetails get profileDetails => _profileDetails.value;
  set profileDetails(value) => _profileDetails.value = value;

  getProfileDetails() async {
    showLoadingDialog();
    try {
      final data = await ProfileRepo().getProfileDetails();
      if (data != null) {
        _profileDetails.value = data;

        update();
        closeLoadingDialog();
      } else {
        debugPrint("Api Error Response error:: ");
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();

      debugPrint("Api  Response error:: $e ");
      rethrow;
    }
  }

  logoutServiceCall() async {
    showLoadingDialog();
    try {
      await ProfileRepo().userLogout(commonService.refreshToken, commonService.deviceId, commonService.deviceType).then((value) async {
        if (value) {
          commonService.accessToken = '';
          commonService.refreshToken = '';
          commonService.username = '';
          commonService.fullname = '';
          commonService.userId = '';

          SessionManager.setAccessToken('');
          SessionManager.setRefreshToken('');
          SessionManager.setUsername('');
          SessionManager.setFullname('');
          SessionManager.setPermissions(['']);
          SessionManager.setUserId('');
          // SocketUtils.socketLogout();
          debugPrint("SplashScreen accessToken: ${commonService.accessToken}");
          debugPrint("SplashScreen refreshToken: ${commonService.refreshToken}");
          debugPrint("SplashScreen username: ${commonService.username}");
          debugPrint("SplashScreen fullname: ${commonService.fullname}");
          debugPrint("SplashScreen userid: ${commonService.userId}");
        }

        // if (title == 'logout') {
        //   showSnackBar(
        //     title: "logout..! Success",
        //     message: 'You have been successfully logged out.',
        //     icon: const Icon(Icons.check_circle_outline, color: Colors.green),
        //   );
        // }
        closeLoadingDialog();
        await Get.toNamed(Routes.loginView);
        update();
      });
    } catch (e) {
      closeLoadingDialog();
      showSnackBar(
        title: "logout..! Failed",
        message: "Please try again",
        icon: const Icon(Icons.close, color: Colors.red),
      );
    }
  }
}
