import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Add%20Retailers%20Forms/add_retailer_personal_details.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Add%20Retailers%20Forms/add_retailers_address_details.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';

class AddRetailersForm extends StatefulWidget {
  const AddRetailersForm({super.key});

  @override
  State<AddRetailersForm> createState() => _AddRetailersFormState();
}

class _AddRetailersFormState extends State<AddRetailersForm> {
  final controller = Get.put(RetailersController());
  final List<GlobalKey<FormState>> _formKeyList = Iterable<int>.generate(3).map((_) => GlobalKey<FormState>()).toList();
  //Bottom Sheet for OrderSummary

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        titleChild: const Text(
          'Add Request',
        ),
        leadingChild: const Icon(
          Icons.arrow_back_rounded,
        ),
        leadingLink: () {
          Get.back();
          controller.discloseControllers();
        },
      ),
      body: GetBuilder<RetailersController>(
        initState: (_) => RetailersController.to.initAddRetailersState(),
        builder: (value) => PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            if (didPop == true) {
              controller.discloseControllers();
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 20),
                      headerWidget(),
                      Container(height: 10),
                      StepProgressIndicator(
                        totalSteps: 2,
                        currentStep: controller.addActiveStep,
                        unselectedColor: Theme.of(context).colorScheme.secondaryContainer,
                        padding: 0,
                        size: 10,
                        roundedEdges: const Radius.circular(20),
                        selectedColor: Theme.of(context).colorScheme.primary,
                      ),
                      Expanded(child: showBobyWidget(context)),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                onPressed: () {
                                  if (controller.addActiveStep == 0) {
                                    Get.back();
                                  } else {
                                    controller.previousStep();
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                            MaterialButton(
                                minWidth: MediaQuery.of(context).size.width / 3,
                                height: 50,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  if (controller.addActiveStep == 0) {
                                    if (_formKeyList[controller.addActiveStep].currentState!.validate()) {
                                      controller.nextStep();
                                    }
                                  } else {
                                    if (_formKeyList[controller.addActiveStep].currentState!.validate()) {
                                      controller.addRetailer();
                                      // controller.nextStep();
                                    }
                                  }
                                },
                                child: const Center(
                                    child: Text("Next",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        )))),
                          ]),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showBobyWidget(context) {
    switch (controller.addActiveStep) {
      case 1:
        return const AddRetailersAddressDetailsWidget();

      default:
        return AddRetailersPersonalDetailsWidget(
          formKey: _formKeyList[controller.addActiveStep],
        );
    }
  }

  Widget headerWidget() {
    switch (controller.addActiveStep) {
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Address Details',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            Text(
              'Steps ${controller.addActiveStep + 1}/2',
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
            )
          ],
        );

      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Retailer Details',
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            Text(
              'Steps ${controller.addActiveStep + 1}/2',
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
            )
          ],
        );
    }
  }
}
