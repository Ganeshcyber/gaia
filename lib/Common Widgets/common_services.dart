import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';

class CommonService {
  static final CommonService _singleton = CommonService._internal();
  CommonService._internal();
  static CommonService get instance => _singleton;

  RegExp passwordPattern = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  RegExp gstinPattern = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');

  RegExp ifscCode = RegExp(r'^[A-Z]{4}[0-9]{7}$');

  int pageSize = 15;
  String deviceId = "";
  String deviceType = "";
  int counter = 0;
  String fullname = "";
  String accessToken = "";
  String refreshToken = "";
  String username = "";
  String retailerName = "";
  String retailerId = "";
  String userProfile = "";
  String userId = "";
  String userMobile = "";
  String userEmail = "";
  List<String> permissions = [];
  String? pushToken;
  String? apnsToken;
  bool isFirstTime = false;
  bool rememberMe = false;

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  static Future<FilePickerResult?> documentPicker() async {
    // showLoadingDialog();
    FilePickerResult? file;
    showLoadingDialog();
    file = await FilePicker.platform.pickFiles(allowMultiple: false);
    // controller.uploadImage(File(file.path));
    closeLoadingDialog();
    return file;
  }

  static Future<XFile?> camerImagePicker() async {
// showLoadingDialog();
    final ImagePicker picker = ImagePicker();
    XFile file;
    showLoadingDialog();
    file = (await picker.pickImage(source: ImageSource.camera))!;
    // controller.uploadImage(File(file.path));
    closeLoadingDialog();
    return file;
  }

  static Future<FilePickerResult?> galleryImagePicker() async {
    // showLoadingDialog();
    // final ImagePicker picker = ImagePicker();
    FilePickerResult? file;
    showLoadingDialog();
    file = (await FilePicker.platform.pickFiles(type: FileType.image))!;
    // controller.uploadImage(File(file.path));
    closeLoadingDialog();
    return file;
  }
}
