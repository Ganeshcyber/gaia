import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/app_logo_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_services.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/session_manager.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Controller/retailer_controller.dart';
import 'package:vaama_dairy_mobile/Screens/Retailers/Model/get_retailers_list_model.dart';

class SelectRetailersView extends StatefulWidget {
  const SelectRetailersView({Key? key}) : super(key: key);

  @override
  State<SelectRetailersView> createState() => _SelectRetailersViewState();
}

class _SelectRetailersViewState extends State<SelectRetailersView> {
  final controller = Get.put(RetailersController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: GetBuilder<RetailersController>(
                initState: (_) => RetailersController.to.initSelectRetailersState(),
                builder: (value) => Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 150),
                              const Center(child: AppLogoWidget()),
                              Container(height: 50),
                              Text(
                                'Retailer!',
                                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
                              ),
                              Text(
                                'Please Select Retailer to Proceed! ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                              ),
                              Container(height: 50),
                              CommonComponents.defaultDropdownSearch<GetRetailersData>(
                                context,
                                title: "Retailer",
                                hintText: "Select Retailer",
                                // prefixIcon: const Icon(
                                //   Icons.pin_drop_outlined,
                                //   size: 20,
                                // ),
                                items: controller.retailersList,
                                // asyncItems: (String? filter) async {
                                //   await miniController.fetchMiniCompanyTypeList();
                                //   return miniController.miniCompanyTypeList;
                                // },
                                itemBuilder: (context, GetRetailersData? item, isSelected) {
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
                                        item?.fullname! ?? '',
                                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                                      ),
                                    ),
                                  );
                                },
                                validator: (GetRetailersData? item) {
                                  if (item == null) {
                                    return 'Retailer is required';
                                  } else {
                                    return null;
                                  }
                                },
                                compareFn: (i, GetRetailersData? s) => i.fullname == s?.fullname,
                                itemAsString: (GetRetailersData u) => u.fullname!,
                                selectedItem: CommonService.instance.retailerId != ''
                                    ? controller.retailersList.any((element) => element.id == CommonService.instance.retailerId)
                                        ? controller.retailersList.firstWhere((element) => element.id == CommonService.instance.retailerId)
                                        : null
                                    : null,
                                onChanged: (GetRetailersData? data) {
                                  // controller.retailersData = data;
                                  CommonService.instance.retailerName = data!.fullname ?? '';
                                  CommonService.instance.retailerId = data.id ?? '';

                                  SessionManager.setRetailerName(data.fullname ?? '');
                                  SessionManager.setRetailerId(data.id ?? '');
                                  controller.getRetailersDetails(data.id, from: 'home');
                                },
                              ),
                              Container(height: 30),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  Get.toNamed(Routes.homeView);
                                  formKey.currentState?.reset();
                                }
                              },
                              child: const Text('Proceed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ),
                        ),
                      )
                    ]))));
  }
}
