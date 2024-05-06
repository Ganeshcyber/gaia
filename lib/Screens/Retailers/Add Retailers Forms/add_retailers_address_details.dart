import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_checkbox_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_done_btn_widget.dart';
import 'package:vaama_dairy_mobile/Masters/MiniController/mini_controller.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_areas_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_cities_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_locations_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_states_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_zones_list.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import '../../../Common Widgets/Common Input Fields/common_input_fields.dart';

class AddRetailersAddressDetailsWidget extends StatefulWidget {
  final GlobalKey? formKey;
  const AddRetailersAddressDetailsWidget({super.key, this.formKey});

  @override
  State<AddRetailersAddressDetailsWidget> createState() => _AddRetailersAddressDetailsWidgetState();
}

class _AddRetailersAddressDetailsWidgetState extends State<AddRetailersAddressDetailsWidget> {
  final focusNodes = Iterable<int>.generate(10).map((_) => FocusNode()).toList();
  final controller = Get.put(RetailersController());
  final miniController = Get.put(MiniController());

  // final List<MiniCommonModel> retailersList = [
  //   MiniCommonModel(id: 1, name: "Male"),
  //   MiniCommonModel(id: 2, name: "Female"),
  //   MiniCommonModel(id: 3, name: "Others"),
  // ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailersController>(
        // initState: (_) => SignUpController.to.initSignUpState(),
        builder: (value) => Expanded(
                child: Form(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: KeyboardActions(
                    tapOutsideBehavior: TapOutsideBehavior.none,
                    disableScroll: true,
                    config: KeyboardActionsConfig(
                      nextFocus: true,
                      defaultDoneWidget: const DoneWidget(),
                      actions: focusNodes.map((focusNode) => KeyboardActionsItem(focusNode: focusNode)).toList(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Biiling Address',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Shop No / Block No',
                          hintText: 'Enter Shop No / Block No',
                          controller: controller.shopNoTF,
                          keyboardType: TextInputType.text,
                          focusNode: Platform.isIOS ? focusNodes[0] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 A-Z a-z , & . / -]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Shop Name is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniStatesData>(
                          context,
                          title: "State",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniStatesList();
                            return miniController.miniStatesList;
                          },
                          itemBuilder: (context, MiniStatesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniStatesData? item) {
                            if (item == null) {
                              return 'State is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniStatesData? s) => i.name == s?.name,
                          itemAsString: (MiniStatesData u) => u.name!,
                          selectedItem: controller.stateId != ''
                              ? miniController.miniStatesList.firstWhere((element) => element.id == controller.stateId)
                              : null,
                          onChanged: (MiniStatesData? data) {
                            controller.stateId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniZonesData>(
                          context,
                          title: "Zone",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniZonesList(stateId: controller.stateId);
                            return miniController.miniZonesList;
                          },
                          itemBuilder: (context, MiniZonesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniZonesData? item) {
                            if (item == null) {
                              return 'Zone is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniZonesData? s) => i.name == s?.name,
                          itemAsString: (MiniZonesData u) => u.name!,
                          selectedItem:
                              controller.zoneId != '' ? miniController.miniZonesList.firstWhere((element) => element.id == controller.zoneId) : null,
                          onChanged: (MiniZonesData? data) {
                            controller.zoneId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniCitiesData>(
                          context,
                          title: "City",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniCitiesList(stateId: controller.stateId, zoneId: controller.zoneId);
                            return miniController.miniCitiesList;
                          },
                          itemBuilder: (context, MiniCitiesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniCitiesData? item) {
                            if (item == null) {
                              return 'City is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniCitiesData? s) => i.name == s?.name,
                          itemAsString: (MiniCitiesData u) => u.name!,
                          selectedItem:
                              controller.cityId != '' ? miniController.miniCitiesList.firstWhere((element) => element.id == controller.cityId) : null,
                          onChanged: (MiniCitiesData? data) {
                            controller.cityId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniAreasData>(
                          context,
                          title: "Area",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniAreasList(cityId: controller.cityId, zoneId: controller.zoneId);
                            return miniController.miniAreasList;
                          },
                          itemBuilder: (context, MiniAreasData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniAreasData? item) {
                            if (item == null) {
                              return 'Area is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniAreasData? s) => i.name == s?.name,
                          itemAsString: (MiniAreasData u) => u.name!,
                          selectedItem:
                              controller.areaId != '' ? miniController.miniAreasList.firstWhere((element) => element.id == controller.areaId) : null,
                          onChanged: (MiniAreasData? data) {
                            controller.areaId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniLocationsData>(
                          context,
                          title: "Location",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniLocationsList(
                                stateId: controller.stateId, cityId: controller.cityId, zoneId: controller.zoneId);
                            return miniController.miniLocationsList;
                          },
                          itemBuilder: (context, MiniLocationsData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniLocationsData? item) {
                            if (item == null) {
                              return 'Location is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniLocationsData? s) => i.name == s?.name,
                          itemAsString: (MiniLocationsData u) => u.name!,
                          selectedItem: controller.locationId != ''
                              ? miniController.miniLocationsList.firstWhere((element) => element.id == controller.locationId)
                              : null,
                          onChanged: (MiniLocationsData? data) {
                            controller.locationId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),

                        CommonComponents.defaultTextField(
                          context,
                          title: 'Pincode',
                          hintText: 'Enter Pincode',
                          controller: controller.pinCodeTF,
                          keyboardType: TextInputType.number,
                          focusNode: Platform.isIOS ? focusNodes[1] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Pincode is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Landmark',
                          hintText: 'Enter Landmark',
                          keyboardType: TextInputType.text,
                          controller: controller.landmarkTF,
                          focusNode: Platform.isIOS ? focusNodes[2] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z a-z]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Landmark is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        InkWell(
                          // focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.changeAcceptedState();
                          },
                          child: Row(
                            children: [
                              CheckBoxWidget(
                                isSelected: controller.isSameBillingAddress,
                              ),
                              Container(
                                width: 5,
                              ),
                              Text(
                                'Billing Address is same as Shipping Address?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 0.1,
                        ),
                        Container(
                          height: 20,
                        ),
                        Text(
                          'Shipping Address',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Shop No / Block No',
                          hintText: 'Enter Shop No / Block No',
                          keyboardType: TextInputType.text,
                          controller: controller.shippingShopNoTF,
                          focusNode: Platform.isIOS ? focusNodes[3] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z a-z]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Shop Name is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniStatesData>(
                          context,
                          title: "State",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniStatesList();
                            return miniController.miniStatesList;
                          },
                          itemBuilder: (context, MiniStatesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniStatesData? item) {
                            if (item == null) {
                              return 'State is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniStatesData? s) => i.name == s?.name,
                          itemAsString: (MiniStatesData u) => u.name!,
                          selectedItem: controller.stateId != ''
                              ? miniController.miniStatesList.firstWhere((element) => element.id == controller.stateId)
                              : controller.shippingStateId != ''
                                  ? miniController.miniStatesList.firstWhere((element) => element.id == controller.shippingStateId)
                                  : null,
                          onChanged: (MiniStatesData? data) {
                            controller.shippingStateId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniZonesData>(
                          context,
                          title: "Zone",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniZonesList(stateId: controller.shippingStateId);
                            return miniController.miniZonesList;
                          },
                          itemBuilder: (context, MiniZonesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniZonesData? item) {
                            if (item == null) {
                              return 'Zone is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniZonesData? s) => i.name == s?.name,
                          itemAsString: (MiniZonesData u) => u.name!,
                          selectedItem: controller.zoneId != ''
                              ? miniController.miniZonesList.firstWhere((element) => element.id == controller.zoneId)
                              : controller.shippingZoneId != ''
                                  ? miniController.miniZonesList.firstWhere((element) => element.id == controller.shippingZoneId)
                                  : null,
                          onChanged: (MiniZonesData? data) {
                            controller.shippingZoneId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniCitiesData>(
                          context,
                          title: "City",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniCitiesList(stateId: controller.shippingStateId, zoneId: controller.shippingZoneId);
                            return miniController.miniCitiesList;
                          },
                          itemBuilder: (context, MiniCitiesData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniCitiesData? item) {
                            if (item == null) {
                              return 'City is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniCitiesData? s) => i.name == s?.name,
                          itemAsString: (MiniCitiesData u) => u.name!,
                          selectedItem: controller.cityId != ''
                              ? miniController.miniCitiesList.firstWhere((element) => element.id == controller.cityId)
                              : controller.shippingCityId != ''
                                  ? miniController.miniCitiesList.firstWhere((element) => element.id == controller.shippingCityId)
                                  : null,
                          onChanged: (MiniCitiesData? data) {
                            controller.shippingCityId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniAreasData>(
                          context,
                          title: "Area",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniAreasList(cityId: controller.shippingCityId, zoneId: controller.shippingZoneId);
                            return miniController.miniAreasList;
                          },
                          itemBuilder: (context, MiniAreasData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniAreasData? item) {
                            if (item == null) {
                              return 'Area is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniAreasData? s) => i.name == s?.name,
                          itemAsString: (MiniAreasData u) => u.name!,
                          selectedItem: controller.areaId != ''
                              ? miniController.miniAreasList.firstWhere((element) => element.id == controller.areaId)
                              : controller.shippingAreaId != ''
                                  ? miniController.miniAreasList.firstWhere((element) => element.id == controller.shippingAreaId)
                                  : null,
                          onChanged: (MiniAreasData? data) {
                            controller.shippingAreaId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultDropdownSearch<MiniLocationsData>(
                          context,
                          title: "Location",
                          hintText: "Select",
                          // items: retailersList,
                          asyncItems: (String? filter) async {
                            await miniController.getMiniLocationsList(
                                stateId: controller.shippingStateId, cityId: controller.shippingCityId, zoneId: controller.shippingZoneId);
                            return miniController.miniLocationsList;
                          },
                          itemBuilder: (context, MiniLocationsData? item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected
                                  ? null
                                  : BoxDecoration(
                                      // border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                    ),
                              child: ListTile(
                                selected: isSelected,
                                title: Text(
                                  item?.name! ?? '',
                                  style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                ),
                              ),
                            );
                          },
                          validator: (MiniLocationsData? item) {
                            if (item == null) {
                              return 'Location is required';
                            } else {
                              return null;
                            }
                          },
                          compareFn: (i, MiniLocationsData? s) => i.name == s?.name,
                          itemAsString: (MiniLocationsData u) => u.name!,
                          // selectedItem: controller.kycData.Retailer != null
                          //     ? retailersList.firstWhere((element) => element.id == controller.kycData.Retailer)
                          //     : null,
                          onChanged: (MiniLocationsData? data) {
                            controller.locationId = data!.id;
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Pincode',
                          hintText: 'Enter Pincode',
                          controller: controller.shippingPinCodeTF,
                          keyboardType: TextInputType.text,
                          focusNode: Platform.isIOS ? focusNodes[4] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z a-z]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Pincode is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Landmark',
                          hintText: 'Enter Landmark',
                          keyboardType: TextInputType.text,
                          controller: controller.shippingLandmarkTF,
                          focusNode: Platform.isIOS ? focusNodes[5] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z a-z]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Landmark is required';
                            } else {
                              return null;
                            }
                          },
                        ),

                        //

                        const SizedBox(height: 120),
                      ],
                    )),
              ),
            )));
  }
}
