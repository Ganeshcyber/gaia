import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_loading_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_areas_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_cities_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_locations_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_product_type_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_states_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_zones_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniRepo/mini_repo.dart';

class MiniController extends GetxController {
  static MiniController get to => Get.find();
  var commonService = CommonService.instance;

  final RxInt _miniProductTypeCurrentPage = 1.obs;
  get miniProductTypeCurrentPage => _miniProductTypeCurrentPage.value;
  set miniProductTypeCurrentPage(value) => _miniProductTypeCurrentPage.value = value;

  final RxInt _miniProductTypeTotalPages = 1.obs;
  get miniProductTypeTotalPages => _miniProductTypeTotalPages.value;
  set miniProductTypeTotalPages(value) => _miniProductTypeTotalPages.value = value;

  final RxBool _miniProductTypeIsRefresh = false.obs;
  get miniProductTypeIsRefresh => _miniProductTypeIsRefresh.value;
  set miniProductTypeIsRefresh(value) => _miniProductTypeIsRefresh.value = value;

  final RxInt _miniProductTypeListCount = 0.obs;
  get miniProductTypeListCount => _miniProductTypeListCount.value;
  set miniProductTypeListCount(value) => _miniProductTypeListCount.value = value;

  final _miniProductTypeList = <MiniProductTypeData>[].obs;
  List<MiniProductTypeData> get miniProductTypeList => _miniProductTypeList;

  getMiniProductTypeList({bool isLoading = true, int? status}) async {
    if (miniProductTypeIsRefresh) {
      _miniProductTypeList.value = <MiniProductTypeData>[];
      miniProductTypeCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniProductTypeCurrentPage > miniProductTypeTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniProductTypeCurrentPage,
      'page_size': CommonService.instance.pageSize,
    };

    try {
      final data = await MiniRepo().getMiniProductTypeList(filterParams);

      if (data != null) {
        miniProductTypeListCount = data.count;
        _miniProductTypeList.value = [...miniProductTypeList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniProductTypeData> filtered = _miniProductTypeList.where((field) => seen.add(field.id!.toString())).toList();
        _miniProductTypeList.value = filtered;
        miniProductTypeIsRefresh = false;

        closeLoadingDialog();
        miniProductTypeTotalPages = (miniProductTypeListCount / CommonService.instance.pageSize).ceil();
        miniProductTypeCurrentPage++;
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

  final RxInt _miniUnitsCurrentPage = 1.obs;
  get miniUnitsCurrentPage => _miniUnitsCurrentPage.value;
  set miniUnitsCurrentPage(value) => _miniUnitsCurrentPage.value = value;

  final RxInt _miniUnitsTotalPages = 1.obs;
  get miniUnitsTotalPages => _miniUnitsTotalPages.value;
  set miniUnitsTotalPages(value) => _miniUnitsTotalPages.value = value;

  final RxBool _miniUnitsIsRefresh = false.obs;
  get miniUnitsIsRefresh => _miniUnitsIsRefresh.value;
  set miniUnitsIsRefresh(value) => _miniUnitsIsRefresh.value = value;

  final RxInt _miniUnitsListCount = 0.obs;
  get miniUnitsListCount => _miniUnitsListCount.value;
  set miniUnitsListCount(value) => _miniUnitsListCount.value = value;

  final _miniUnitsList = <MiniUnitsData>[].obs;
  List<MiniUnitsData> get miniUnitsList => _miniUnitsList;

  getMiniUnitsList({bool isLoading = true, int? status}) async {
    if (miniUnitsIsRefresh) {
      _miniUnitsList.value = <MiniUnitsData>[];
      miniUnitsCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniUnitsCurrentPage > miniUnitsTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniUnitsCurrentPage,
      'page_size': CommonService.instance.pageSize,
    };

    try {
      final data = await MiniRepo().getMiniUnitsList(filterParams);

      if (data != null) {
        miniUnitsListCount = data.count;
        _miniUnitsList.value = [...miniUnitsList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniUnitsData> filtered = _miniUnitsList.where((field) => seen.add(field.id!.toString())).toList();
        _miniUnitsList.value = filtered;
        miniUnitsIsRefresh = false;

        closeLoadingDialog();
        miniUnitsTotalPages = (miniUnitsListCount / CommonService.instance.pageSize).ceil();
        miniUnitsCurrentPage++;
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

  final RxInt _miniStatesCurrentPage = 1.obs;
  get miniStatesCurrentPage => _miniStatesCurrentPage.value;
  set miniStatesCurrentPage(value) => _miniStatesCurrentPage.value = value;

  final RxInt _miniStatesTotalPages = 1.obs;
  get miniStatesTotalPages => _miniStatesTotalPages.value;
  set miniStatesTotalPages(value) => _miniStatesTotalPages.value = value;

  final RxBool _miniStatesIsRefresh = false.obs;
  get miniStatesIsRefresh => _miniStatesIsRefresh.value;
  set miniStatesIsRefresh(value) => _miniStatesIsRefresh.value = value;

  final RxInt _miniStatesListCount = 0.obs;
  get miniStatesListCount => _miniStatesListCount.value;
  set miniStatesListCount(value) => _miniStatesListCount.value = value;

  final _miniStatesList = <MiniStatesData>[].obs;
  List<MiniStatesData> get miniStatesList => _miniStatesList;

  getMiniStatesList({bool isLoading = true, int? status}) async {
    if (miniStatesIsRefresh) {
      _miniStatesList.value = <MiniStatesData>[];
      miniStatesCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniStatesCurrentPage > miniStatesTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniStatesCurrentPage,
      'page_size': CommonService.instance.pageSize,
    };

    try {
      final data = await MiniRepo().getMiniStatesList(filterParams);

      if (data != null) {
        miniStatesListCount = data.count;
        _miniStatesList.value = [...miniStatesList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniStatesData> filtered = _miniStatesList.where((field) => seen.add(field.id!.toString())).toList();
        _miniStatesList.value = filtered;
        miniStatesIsRefresh = false;

        closeLoadingDialog();
        miniStatesTotalPages = (miniStatesListCount / CommonService.instance.pageSize).ceil();
        miniStatesCurrentPage++;
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

  final RxInt _miniCitiesCurrentPage = 1.obs;
  get miniCitiesCurrentPage => _miniCitiesCurrentPage.value;
  set miniCitiesCurrentPage(value) => _miniCitiesCurrentPage.value = value;

  final RxInt _miniCitiesTotalPages = 1.obs;
  get miniCitiesTotalPages => _miniCitiesTotalPages.value;
  set miniCitiesTotalPages(value) => _miniCitiesTotalPages.value = value;

  final RxBool _miniCitiesIsRefresh = false.obs;
  get miniCitiesIsRefresh => _miniCitiesIsRefresh.value;
  set miniCitiesIsRefresh(value) => _miniCitiesIsRefresh.value = value;

  final RxInt _miniCitiesListCount = 0.obs;
  get miniCitiesListCount => _miniCitiesListCount.value;
  set miniCitiesListCount(value) => _miniCitiesListCount.value = value;

  final _miniCitiesList = <MiniCitiesData>[].obs;
  List<MiniCitiesData> get miniCitiesList => _miniCitiesList;

  getMiniCitiesList({bool isLoading = true, int? status, required String stateId, required String zoneId}) async {
    if (miniCitiesIsRefresh) {
      _miniCitiesList.value = <MiniCitiesData>[];
      miniCitiesCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniCitiesCurrentPage > miniCitiesTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniCitiesCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'state': stateId,
      'zone': zoneId
    };

    try {
      final data = await MiniRepo().getMiniCitiesList(filterParams);

      if (data != null) {
        miniCitiesListCount = data.count;
        _miniCitiesList.value = [...miniCitiesList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniCitiesData> filtered = _miniCitiesList.where((field) => seen.add(field.id!.toString())).toList();
        _miniCitiesList.value = filtered;
        miniCitiesIsRefresh = false;

        closeLoadingDialog();
        miniCitiesTotalPages = (miniCitiesListCount / CommonService.instance.pageSize).ceil();
        miniCitiesCurrentPage++;
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

  final RxInt _miniZonesCurrentPage = 1.obs;
  get miniZonesCurrentPage => _miniZonesCurrentPage.value;
  set miniZonesCurrentPage(value) => _miniZonesCurrentPage.value = value;

  final RxInt _miniZonesTotalPages = 1.obs;
  get miniZonesTotalPages => _miniZonesTotalPages.value;
  set miniZonesTotalPages(value) => _miniZonesTotalPages.value = value;

  final RxBool _miniZonesIsRefresh = false.obs;
  get miniZonesIsRefresh => _miniZonesIsRefresh.value;
  set miniZonesIsRefresh(value) => _miniZonesIsRefresh.value = value;

  final RxInt _miniZonesListCount = 0.obs;
  get miniZonesListCount => _miniZonesListCount.value;
  set miniZonesListCount(value) => _miniZonesListCount.value = value;

  final _miniZonesList = <MiniZonesData>[].obs;
  List<MiniZonesData> get miniZonesList => _miniZonesList;

  getMiniZonesList({bool isLoading = true, int? status, required String stateId}) async {
    if (miniZonesIsRefresh) {
      _miniZonesList.value = <MiniZonesData>[];
      miniZonesCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniZonesCurrentPage > miniZonesTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{'page': miniZonesCurrentPage, 'page_size': CommonService.instance.pageSize, 'state': stateId};

    try {
      final data = await MiniRepo().getMiniZonesList(filterParams);

      if (data != null) {
        miniZonesListCount = data.count;
        _miniZonesList.value = [...miniZonesList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniZonesData> filtered = _miniZonesList.where((field) => seen.add(field.id!.toString())).toList();
        _miniZonesList.value = filtered;
        miniZonesIsRefresh = false;

        closeLoadingDialog();
        miniZonesTotalPages = (miniZonesListCount / CommonService.instance.pageSize).ceil();
        miniZonesCurrentPage++;
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

  final RxInt _miniAreasCurrentPage = 1.obs;
  get miniAreasCurrentPage => _miniAreasCurrentPage.value;
  set miniAreasCurrentPage(value) => _miniAreasCurrentPage.value = value;

  final RxInt _miniAreasTotalPages = 1.obs;
  get miniAreasTotalPages => _miniAreasTotalPages.value;
  set miniAreasTotalPages(value) => _miniAreasTotalPages.value = value;

  final RxBool _miniAreasIsRefresh = false.obs;
  get miniAreasIsRefresh => _miniAreasIsRefresh.value;
  set miniAreasIsRefresh(value) => _miniAreasIsRefresh.value = value;

  final RxInt _miniAreasListCount = 0.obs;
  get miniAreasListCount => _miniAreasListCount.value;
  set miniAreasListCount(value) => _miniAreasListCount.value = value;

  final _miniAreasList = <MiniAreasData>[].obs;
  List<MiniAreasData> get miniAreasList => _miniAreasList;

  getMiniAreasList({bool isLoading = true, int? status, required String cityId, required String zoneId}) async {
    if (miniAreasIsRefresh) {
      _miniAreasList.value = <MiniAreasData>[];
      miniAreasCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniAreasCurrentPage > miniAreasTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniAreasCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'city': cityId,
      'zone': zoneId
    };

    try {
      final data = await MiniRepo().getMiniAreasList(filterParams);

      if (data != null) {
        miniAreasListCount = data.count;
        _miniAreasList.value = [...miniAreasList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniAreasData> filtered = _miniAreasList.where((field) => seen.add(field.id!.toString())).toList();
        _miniAreasList.value = filtered;
        miniAreasIsRefresh = false;

        closeLoadingDialog();
        miniAreasTotalPages = (miniAreasListCount / CommonService.instance.pageSize).ceil();
        miniAreasCurrentPage++;
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

  final RxInt _miniLocationsCurrentPage = 1.obs;
  get miniLocationsCurrentPage => _miniLocationsCurrentPage.value;
  set miniLocationsCurrentPage(value) => _miniLocationsCurrentPage.value = value;

  final RxInt _miniLocationsTotalPages = 1.obs;
  get miniLocationsTotalPages => _miniLocationsTotalPages.value;
  set miniLocationsTotalPages(value) => _miniLocationsTotalPages.value = value;

  final RxBool _miniLocationsIsRefresh = false.obs;
  get miniLocationsIsRefresh => _miniLocationsIsRefresh.value;
  set miniLocationsIsRefresh(value) => _miniLocationsIsRefresh.value = value;

  final RxInt _miniLocationsListCount = 0.obs;
  get miniLocationsListCount => _miniLocationsListCount.value;
  set miniLocationsListCount(value) => _miniLocationsListCount.value = value;

  final _miniLocationsList = <MiniLocationsData>[].obs;
  List<MiniLocationsData> get miniLocationsList => _miniLocationsList;

  getMiniLocationsList({bool isLoading = true, int? status, required String stateId, required String cityId, required String zoneId}) async {
    if (miniLocationsIsRefresh) {
      _miniLocationsList.value = <MiniLocationsData>[];
      miniLocationsCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (miniLocationsCurrentPage > miniLocationsTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': miniLocationsCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'state': stateId,
      'city': cityId,
      'zone': zoneId,
    };

    try {
      final data = await MiniRepo().getMiniLocationsList(filterParams);

      if (data != null) {
        miniLocationsListCount = data.count;
        _miniLocationsList.value = [...miniLocationsList, ...data.results ?? []];
        var seen = <String>{};
        List<MiniLocationsData> filtered = _miniLocationsList.where((field) => seen.add(field.id!.toString())).toList();
        _miniLocationsList.value = filtered;
        miniLocationsIsRefresh = false;

        closeLoadingDialog();
        miniLocationsTotalPages = (miniLocationsListCount / CommonService.instance.pageSize).ceil();
        miniLocationsCurrentPage++;
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
}
