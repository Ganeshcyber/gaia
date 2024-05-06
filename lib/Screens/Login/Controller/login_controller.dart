import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_snackbar_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Login/Model/login_post_model.dart';
import 'package:vaama_dairy_mobile/Screens/Login/Repo/login_repo.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var commonService = CommonService.instance;

  // final dashboardController = Get.put(DashBoardController());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RxBool _obscureText = true.obs;
  get obscureText => _obscureText.value;
  set obscureText(value) => _obscureText.value = value;

  final RxBool _loginButtonEnable = false.obs;
  get loginButtonEnable => _loginButtonEnable.value;
  set loginButtonEnable(value) => _loginButtonEnable.value = value;

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userNameController.clear();
      passwordController.clear();
      loginButtonEnable = false;
      // if (commonService.accessToken != '') {
      //   Get.toNamed(Routes.dashboard);
      // } else {
      //   Get.toNamed(Routes.loginView);
      // }
    });
  }

  loginServiceCall() async {
    Login mobileOTPVerifyObj = Login();
    mobileOTPVerifyObj.username = userNameController.text;
    mobileOTPVerifyObj.otp = passwordController.text;
    mobileOTPVerifyObj.apnsToken = commonService.apnsToken ?? '';
    mobileOTPVerifyObj.pushToken = commonService.pushToken ?? '';
    // final userdata = Hive.box<UserLoginData>("userData");
    showLoadingDialog();
    try {
      final data = await LoginRepo().login(mobileOTPVerifyObj.username, mobileOTPVerifyObj.otp, commonService.deviceId, commonService.deviceType,
          mobileOTPVerifyObj.pushToken, mobileOTPVerifyObj.apnsToken);

      print('post data is ${data}');
      closeLoadingDialog();
      if (data != null) {
        Get.back();
        commonService.accessToken = data.tokens != null && data.tokens!.access != null ? data.tokens!.access ?? '' : '';
        commonService.refreshToken = data.tokens != null && data.tokens!.refresh != null ? data.tokens!.refresh ?? '' : '';
        commonService.username = data.fullName ?? '';
        commonService.userEmail = data.email ?? '';
        commonService.userMobile = data.phone ?? '';
        commonService.userProfile = data.groupName ?? '';
        commonService.userId = data.id ?? '';

        SessionManager.setAccessToken(data.tokens != null && data.tokens!.access != null ? data.tokens!.access ?? '' : '');
        SessionManager.setRefreshToken(data.tokens != null && data.tokens!.refresh != null ? data.tokens!.refresh ?? '' : '');
        SessionManager.setUsername(data.fullName ?? '');
        SessionManager.setUserProfile(data.groupName ?? '');
        SessionManager.setUserEmail(data.email ?? '');
        SessionManager.setUserMobile(data.phone ?? '');
        SessionManager.setUserId(data.id ?? '');
        SessionManager.setIsFirstTime(true);
        // SocketUtils.socketLogin();
        commonService.isFirstTime = await SessionManager.getIsFirstTime();

        await getPermissions();
        // SocketUtils.socketLogin();

        Get.toNamed(Routes.homeView);

        return true;
      } else {
        showSnackBar(
          title: "login..! Failed",
          message: 'Incorrect OTP, Please try again',
          icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
        );
        debugPrint("Api Error Response error:: ");
        return false;
      }
    } catch (e) {
      debugPrint(
        "user login error: ${e}",
      );
      showSnackBar(
        title: "login..! Failed",
        message: e.toString(),
        icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      );
      closeLoadingDialog();
      rethrow;
    }
  }

  // logoutServiceCall({String? title}) async {
  //   try {
  //     await LoginRepo().userLogout(commonService.refreshToken, commonService.deviceId, commonService.deviceType).then((value) async {
  //       if (value) {
  //         commonService.accessToken = '';
  //         commonService.refreshToken = '';
  //         commonService.username = '';
  //         commonService.fullname = '';
  //         commonService.odometerReading = 0;

  //         SessionManager.setAccessToken('');
  //         SessionManager.setRefreshToken('');
  //         SessionManager.setUsername('');
  //         SessionManager.setFullname('');
  //         SessionManager.setOdometerReading(0);
  //         SessionManager.setPermissions(['']);

  //         debugPrint("SplashScreen accessToken: ${commonService.accessToken}");
  //         debugPrint("SplashScreen refreshToken: ${commonService.refreshToken}");
  //         debugPrint("SplashScreen username: ${commonService.username}");
  //         debugPrint("SplashScreen fullname: ${commonService.fullname}");
  //         debugPrint("SplashScreen fullname: ${commonService.odometerReading}");
  //       }

  //       if (title == 'logout') {
  //         showSnackBar(
  //           title: "logout..! Success",
  //           message: 'You have been successfully logged out.',
  //           icon: const Icon(Icons.check_circle_outline, color: Colors.green),
  //         );
  //       }
  //       await Get.toNamed(Routes.loginView);
  //       update();
  //     });
  //   } catch (e) {
  //     showSnackBar(
  //       title: "logout..! Failed",
  //       message: "Please try again",
  //       icon: const Icon(Icons.close, color: Colors.red),
  //     );
  //   }
  // }

  getPermissions() async {
    try {
      await LoginRepo().getPermissions().then((value) async {
        if (value != null) {
          SessionManager.setPermissions(List<String>.from(await value));
          commonService.permissions = List<String>.from(await value);
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
