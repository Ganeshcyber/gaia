import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import '../../Routes/app_pages.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //   // await Firebase.initializeApp(
  //   // );
  //   print('Handling a background message ${message.messageId}');
  // }

  // late AndroidNotificationChannel channel;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // initFirebase() async {
  //   // await Firebase.initializeApp(
  //   //     // options: DefaultFirebaseOptions.currentPlatform,
  //   //     );

  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     commonService.deviceId = androidInfo.id;
  //   } else {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     commonService.deviceId = iosInfo.identifierForVendor!;
  //   }

  //   commonService.deviceType = Platform.operatingSystem;
  //   print("Print id:${commonService.deviceId}");
  //   print("Print Type:${commonService.deviceType}");
  //   // if (!kIsWeb) {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description: 'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );

  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);

  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   // }
  // }

  @override
  void initState() {
    super.initState();

    // initFirebase();
    // LocalNotificationServices.initialize(context);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   print("Printing Notification message in onmessage: ${message.data}");

    //   if (notification != null && android != null && !kIsWeb) {
    //     // flutterLocalNotificationsPlugin.show(
    //     //   notification.hashCode,
    //     //   notification.title,
    //     //   notification.body,
    //     //     android: AndroidNotificationDetails(
    //     //       channel.id,
    //     //       channel.name,
    //     //       channelDescription: channel.description,
    //     //       // TODO add a proper drawable resource to android, for now using
    //     //       //      one that already exists in example app.
    //     //       icon: 'launch_background',
    //     //     ),
    //     //   ),
    //     // );
    //   } //   NotificationDetails(

    //   LocalNotificationServices.display(message);
    // });
    // if (Platform.isIOS) {
    //   FirebaseMessaging.instance.getAPNSToken().then((value) {
    //     commonService.apnsToken = value;
    //     print("Priniting Apple token: $value");
    //     print("common apple token: ${commonService.apnsToken}");
    //   });
    // }
    // FirebaseMessaging.instance.getToken().then((value) {
    //   commonService.pushToken = value;
    //   print("Priniting token: $value");
    //   print("common android token: ${commonService.pushToken}");
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   print("Printing Notification message in open: ${message.data}");
    // });
    _initPackageInfo();

    _getId().then((id) {
      commonService.deviceId = id;
      commonService.deviceType = Platform.operatingSystem;
    });
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 5), () => isFirstUserOrNot());
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    commonService.packageInfo = info;
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor!; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  var commonService = CommonService.instance;

  isFirstUserOrNot() async {
    commonService.accessToken = await SessionManager.getAccessToken();
    commonService.refreshToken = await SessionManager.getRefreshToken();
    commonService.username = await SessionManager.getUsername();
    commonService.userEmail = await SessionManager.getUserEmail();
    commonService.userMobile = await SessionManager.getUserMobile();
    commonService.userProfile = await SessionManager.getUserProfile();
    commonService.userId = await SessionManager.getUserId();
    commonService.permissions = await SessionManager.getPermissions();
    commonService.rememberMe = await SessionManager.getRememberMe();
    commonService.retailerName = await SessionManager.getRetailerName();
    commonService.retailerId = await SessionManager.getRetailerId();
    SessionManager.setIsFirstTime(true);
    commonService.isFirstTime = await SessionManager.getIsFirstTime();
    debugPrint("Access Token::::::${commonService.accessToken}");
    debugPrint("Retailer name::::::${commonService.retailerName}");
    debugPrint("Retailer Id::::::${commonService.retailerId}");

    if (commonService.accessToken != '') {
      Get.toNamed(Routes.homeView);
    } else {
      Get.toNamed(Routes.loginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Image.asset(
          'assets/app_logo/app_logo.png',
        ),
      ),
    ));
  }
}
