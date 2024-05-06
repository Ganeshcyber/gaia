import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/App%20Bar/custom_app_bar.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Controller/profile_controller.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsView();
}

class _ProfileDetailsView extends State<ProfileDetailsView> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleChild: const Text('Profile Details'),
        leadingChild: const Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 36,
        ),
        leadingLink: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Container(
              height: 20,
            ),
            Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.surface),
                    ),
                    Container(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Container(
                          width: 60,
                        ),
                        Expanded(
                          child: Text(
                            controller.profileDetails.username ?? 'N/A',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone No',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Container(
                          width: 60,
                        ),
                        Expanded(
                          child: Text(
                            controller.profileDetails.phone ?? 'N/A',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Alternate No',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Container(
                          width: 60,
                        ),
                        Expanded(
                          child: Text(
                            controller.profileDetails.phone ?? 'N/A',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Container(
                          width: 60,
                        ),
                        Expanded(
                          child: Text(
                            controller.profileDetails.email ?? 'N/A',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.surface),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
