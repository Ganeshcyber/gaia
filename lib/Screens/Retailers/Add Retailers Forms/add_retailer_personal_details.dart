import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_done_btn_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Controller/profile_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:email_validator/email_validator.dart';
import '../../../Common Widgets/Common Input Fields/common_input_fields.dart';

class AddRetailersPersonalDetailsWidget extends StatefulWidget {
  final GlobalKey? formKey;
  const AddRetailersPersonalDetailsWidget({super.key, this.formKey});

  @override
  State<AddRetailersPersonalDetailsWidget> createState() => _AddRetailersPersonalDetailsWidgetState();
}

class _AddRetailersPersonalDetailsWidgetState extends State<AddRetailersPersonalDetailsWidget> {
  final focusNodes = Iterable<int>.generate(10).map((_) => FocusNode()).toList();
  final controller = Get.put(RetailersController());
  final profileController = Get.put(ProfileController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.requestPermission();
    // permission = await Geolocator.checkPermission();
    print("GSP Status:::::::${servicestatus}");
    // if (servicestatus) {
    permission = await Geolocator.checkPermission();
    print("GSP Status:::::::${permission}");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        haspermission = true;
      }
    } else {
      haspermission = true;
    }

    if (haspermission) {
      getLocation();
    }
    // } else {
    //   print("GPS Service is not enabled, turn on GPS location");
    // }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //Output: 29.6593457

    controller.lon = position.longitude.toString();
    controller.lat = position.latitude.toString();
    controller.gpsLocationTF.text = "${position.longitude.toString()},${position.latitude.toString()}";

    setState(() {
      //refresh UI
    });
  }

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Retailer',
                          hintText: 'Enter Retailer',
                          controller: controller.retailerNameTF,
                          keyboardType: TextInputType.text,
                          focusNode: Platform.isIOS ? focusNodes[0] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z a-z]'))],
                          validator: (val) {
                            if (val == '') {
                              return 'Retailer is required';
                            } else {
                              return null;
                            }
                          },
                          onChange: (String val) {},
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'GST Number',
                          hintText: 'Enter GST Number',
                          controller: controller.gstNumTF,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 A-Z]'))],
                          focusNode: Platform.isIOS ? focusNodes[1] : null,
                          validator: (val) {
                            if (val.trim() != '') {
                              if (CommonService.instance.gstinPattern.hasMatch(val)) {
                                return null;
                              } else {
                                return 'Please enter a valid GST identification number';
                              }
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.characters,
                          onChange: (String val) {},
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Mobile Number',
                          hintText: 'Enter Mobile Number',
                          maxLength: 10,
                          controller: controller.mobileNumTF,
                          validator: (String? val) {
                            if (val == '') {
                              return 'Mobile number is required';
                            } else if (val!.length < 10) {
                              return 'Please enter valid mobile number';
                            } else {
                              return null;
                            }
                          },
                          focusNode: Platform.isIOS ? focusNodes[2] : null,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          keyboardType: TextInputType.phone,
                          onChange: (String val) {},
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Alternate Number',
                          hintText: 'Enter Alternate Number(Optional)',
                          controller: controller.altNumTF,
                          focusNode: Platform.isIOS ? focusNodes[3] : null,
                          maxLength: 10,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          keyboardType: TextInputType.phone,
                          onChange: (String val) {},
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'Email ID',
                          hintText: 'Enter Email ID',
                          controller: controller.emailIdTF,
                          textInputAction: TextInputAction.done,
                          focusNode: Platform.isIOS ? focusNodes[4] : null,
                          validator: (String? value) => value != ''
                              ? EmailValidator.validate(value!)
                                  ? null
                                  : 'Please enter a valid email ID'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (String val) {},
                        ),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(context,
                            title: 'Sale Agent',
                            hintText: 'Sale Agent',
                            readOnly: true,
                            controller: TextEditingController(text: profileController.profileDetails.fullname)),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(context,
                            title: 'Distributor',
                            hintText: 'Distributor',
                            readOnly: true,
                            controller: TextEditingController(text: profileController.profileDetails.distributor!.fullname)),
                        Container(
                          height: 20,
                        ),
                        CommonComponents.defaultTextField(
                          context,
                          title: 'GPS Location',
                          controller: controller.gpsLocationTF,
                          hintText: 'Click to Get the GPS Location',
                          readOnly: true,
                          onTap: () {
                            checkGps();
                          },
                          validator: (String? value) => value != '' ? null : "Please select location",
                        ),

                        //

                        const SizedBox(height: 120),
                      ],
                    )),
              ),
            )));
  }
}
