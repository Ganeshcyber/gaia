import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Controller/profile_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailer_details.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Repo/retailers_repo.dart';
import '../../../Common Widgets/common_services.dart';

class RetailersController extends GetxController {
  static RetailersController get to => Get.find();
  var commonService = CommonService.instance;

  final profileController = Get.put(ProfileController());

  final RxInt _addActiveStep = 0.obs;
  get addActiveStep => _addActiveStep.value;
  set addActiveStep(value) => _addActiveStep.value = value;

  nextStep() {
    _addActiveStep.value++;
    print('active step is ${addActiveStep}');

    // _addActiveStep.value = 5;

    update();
  }

  previousStep() {
    _addActiveStep.value--;
    update();
  }

  initAddRetailersState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      addActiveStep = 0;
      shippingStateId = '';
      shippingZoneId = '';
      shippingCityId = '';
      shippingAreaId = '';
      stateId = '';
      zoneId = '';
      cityId = '';
      areaId = '';
      isSameBillingAddress = false;
      lat = '';
      lon = '';
    });
  }

  final RxBool _isSameBillingAddress = false.obs;
  get isSameBillingAddress => _isSameBillingAddress.value;
  set isSameBillingAddress(value) => _isSameBillingAddress.value = value;

  discloseControllers() {
    retailerNameTF.clear();
    gstNumTF.clear();
    mobileNumTF.clear();
    altNumTF.clear();
    emailIdTF.clear();
    gpsLocationTF.clear();
    shopNoTF.clear();
    pinCodeTF.clear();
    landmarkTF.clear();
    shippingShopNoTF.clear();
    shippingPinCodeTF.clear();
    shippingLandmarkTF.clear();
    shippingStateId = '';
    shippingZoneId = '';
    shippingCityId = '';
    shippingAreaId = '';
    stateId = '';
    zoneId = '';
    cityId = '';
    areaId = '';
    isSameBillingAddress = false;
    lat = '';
    lon = '';
  }

  changeAcceptedState() {
    isSameBillingAddress = !isSameBillingAddress;
    if (isSameBillingAddress == true) {
      shippingPinCodeTF.text = pinCodeTF.text;
      shippingShopNoTF.text = shopNoTF.text;
      shippingLandmarkTF.text = landmarkTF.text;
      shippingStateId = stateId;
      shippingZoneId = zoneId;
      shippingCityId = cityId;
      shippingAreaId = areaId;
    } else {
      shippingPinCodeTF.clear();
      shippingShopNoTF.clear();
      shippingLandmarkTF.clear();
      shippingStateId = '';
      shippingZoneId = '';
      shippingCityId = '';
      shippingAreaId = '';
    }
    // SharedPreferences.getInstance().then(
    //   (prefs) {
    //     if (isSameBillingAddress) {
    //       commonService.sameBillingAddress = true;
    //       SessionManager.setSameBillingAddress(true);
    //     } else {
    //       commonService.sameBillingAddress = false;
    //       SessionManager.setSameBillingAddress(false);
    //     }
    //     prefs.setString('userMobile', mobileNumberCntrl.text);
    //     prefs.setString('password', passwordController.text);
    //   },
    // );
    update();
  }

  initSelectRetailersState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      retailersIsRefresh = true;
      getRetailersList();
    });
  }

  final RxInt _retailersCurrentPage = 1.obs;
  get retailersCurrentPage => _retailersCurrentPage.value;
  set retailersCurrentPage(value) => _retailersCurrentPage.value = value;

  final RxInt _retailersTotalPages = 1.obs;
  get retailersTotalPages => _retailersTotalPages.value;
  set retailersTotalPages(value) => _retailersTotalPages.value = value;

  final RxBool _retailersIsRefresh = false.obs;
  get retailersIsRefresh => _retailersIsRefresh.value;
  set retailersIsRefresh(value) => _retailersIsRefresh.value = value;

  final RxInt _retailersListCount = 0.obs;
  get retailersListCount => _retailersListCount.value;
  set retailersListCount(value) => _retailersListCount.value = value;

  final _retailersList = <GetRetailersData>[].obs;
  List<GetRetailersData> get retailersList => _retailersList;

  getRetailersList({bool isLoading = true, int? status}) async {
    if (retailersIsRefresh) {
      _retailersList.value = <GetRetailersData>[];
      retailersCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (retailersCurrentPage > retailersTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': retailersCurrentPage,
      'page_size': CommonService.instance.pageSize,
    };

    try {
      final data = await RetailersRepo().getRetailersList(filterParams);

      if (data != null) {
        retailersListCount = data.count;
        _retailersList.value = [...retailersList, ...data.results ?? []];
        var seen = <String>{};
        List<GetRetailersData> filtered = _retailersList.where((field) => seen.add(field.id!.toString())).toList();
        _retailersList.value = filtered;
        retailersIsRefresh = false;

        // if (retailersList.any((element) => element.id != CommonService.instance.retailerId)) {
        //   SessionManager.setRetailerId('');
        //   SessionManager.setRetailerName('');
        //   commonService.retailerId = '';
        //   commonService.retailerName = '';
        // }
        update();
        closeLoadingDialog();
        retailersTotalPages = (retailersListCount / CommonService.instance.pageSize).ceil();
        retailersCurrentPage++;
        update();
        return true;
      } else {
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }

  final _retailersDetails = GetRetailersDetails().obs;
  GetRetailersDetails get retailersDetails => _retailersDetails.value;
  set retailersDetails(value) => _retailersDetails.value = value;

  getRetailersDetails(id, {String? from}) async {
    showLoadingDialog();
    try {
      closeLoadingDialog();

      final data = await RetailersRepo().getRetailersDetails(id);
      if (data != null) {
        _retailersDetails.value = data;
        print('object:::::::::::::::;retailer object is $retailersDetails');
        if (from == 'home') {
          CommonService.instance.retailerName = retailersDetails.fullname ?? '';
          CommonService.instance.retailerId = retailersDetails.id ?? '';
          SessionManager.setRetailerName(retailersDetails.fullname ?? '');
          SessionManager.setRetailerId(retailersDetails.id ?? '');
        } else {
          Get.toNamed(Routes.retailersViewById);
        }

        update();
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

  final RxString _lat = ''.obs;
  get lat => _lat.value;
  set lat(value) => _lat.value = value;

  final RxString _lon = ''.obs;
  get lon => _lon.value;
  set lon(value) => _lon.value = value;

  final RxString _locationId = ''.obs;
  get locationId => _locationId.value;
  set locationId(value) => _locationId.value = value;

  final RxString _stateId = ''.obs;
  get stateId => _stateId.value;
  set stateId(value) => _stateId.value = value;

  final RxString _cityId = ''.obs;
  get cityId => _cityId.value;
  set cityId(value) => _cityId.value = value;

  final RxString _zoneId = ''.obs;
  get zoneId => _zoneId.value;
  set zoneId(value) => _zoneId.value = value;

  final RxString _areaId = ''.obs;
  get areaId => _areaId.value;
  set areaId(value) => _areaId.value = value;

  final RxString _shippingStateId = ''.obs;
  get shippingStateId => _shippingStateId.value;
  set shippingStateId(value) => _shippingStateId.value = value;

  final RxString _shippingCityId = ''.obs;
  get shippingCityId => _shippingCityId.value;
  set shippingCityId(value) => _shippingCityId.value = value;

  final RxString _shippingZoneId = ''.obs;
  get shippingZoneId => _shippingZoneId.value;
  set shippingZoneId(value) => _shippingZoneId.value = value;

  final RxString _shippingAreaId = ''.obs;
  get shippingAreaId => _shippingAreaId.value;
  set shippingAreaId(value) => _shippingAreaId.value = value;

  TextEditingController retailerNameTF = TextEditingController();
  TextEditingController gstNumTF = TextEditingController();
  TextEditingController mobileNumTF = TextEditingController();
  TextEditingController altNumTF = TextEditingController();
  TextEditingController emailIdTF = TextEditingController();
  TextEditingController gpsLocationTF = TextEditingController();
  TextEditingController shopNoTF = TextEditingController();
  TextEditingController pinCodeTF = TextEditingController();
  TextEditingController landmarkTF = TextEditingController();
  TextEditingController shippingShopNoTF = TextEditingController();
  TextEditingController shippingPinCodeTF = TextEditingController();
  TextEditingController shippingLandmarkTF = TextEditingController();

  // final _retailersData = GetRetailersData().obs;
  // GetRetailersData get retailersData => _retailersData.value;
  // set retailersData(value) => _retailersData.value = value;

  addRetailer() async {
    var postData = {
      "email": emailIdTF.text,
      "phone": mobileNumTF.text,
      "alternate_phone": altNumTF.text,
      "first_name": retailerNameTF.text,
      "gst_no": gstNumTF.text,
      "location_id": locationId,
      "gender": 1,
      "latitude": lat,
      "longitude": lon,
      "default_billing_address": {
        "d_no": shopNoTF.text,
        "area_id": areaId,
        "city_id": cityId,
        "state_id": stateId,
        "landmark": landmarkTF.text,
        "pincode": pinCodeTF.text
      },
      "default_shipping_address": {
        "d_no": shippingShopNoTF.text,
        "area_id": shippingAreaId,
        "city_id": shippingCityId,
        "state_id": shippingStateId,
        "landmark": shippingLandmarkTF.text,
        "pincode": shippingPinCodeTF.text
      },
      "is_shipping_as_billing": isSameBillingAddress,
      "salesagent_id": profileController.profileDetails.id
    };
    print("Add Retailer Post Data :::::: ${jsonEncode(postData)}");
    try {
      var data = await RetailersRepo().addRetailer(postData);
      closeLoadingDialog();
      if (data != null) {
        print("Add Retailer Post Data :::::: ${jsonEncode(postData)}");
        discloseControllers();
      }
    } catch (e) {
      debugPrint(
        "Api Error Response: $e",
      );

      closeLoadingDialog();
    }
  }
}
