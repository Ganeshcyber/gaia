import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaama_dairy_mobile/Routes/app_pages.dart';
import 'package:vaama_dairy_mobile/Screens/Profile/Controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        initState: (_) => ProfileController.to.initState(),
        builder: (value) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      // controller.getProfileDetails();

                      Get.toNamed(Routes.profileDetailsView);
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 244, 248, 251),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/profile.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Profile Details',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        // controller.getProfileDetails();
                        Get.toNamed(Routes.profileDetailsView);
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 244, 248, 251),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                          .withOpacity(0.05)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/images/profile.svg'),
                                  )),
                              Container(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Distributor Details ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right_outlined)
                            ],
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.retailersListView);
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 244, 248, 251),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/store.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Retailers ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.myCartView);
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 244, 248, 251),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/shopping_cart.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Cart',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.notificationsListView);
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 244, 248, 251),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/bell.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Notifications',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.logoutServiceCall();
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 244, 248, 251),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/logout.svg'),
                                )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Logout',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ));
  }
}
