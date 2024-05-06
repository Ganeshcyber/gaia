import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/app_logo_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/common_done_btn_widget.dart';
import 'package:vaama_dairy_mobile/Common%20Widgets/Common%20Input%20Fields/common_input_fields.dart';
import 'package:vaama_dairy_mobile/Screens/Login/Controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final focusNodes = Iterable<int>.generate(2).map((_) => FocusNode()).toList();
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: GetBuilder<LoginController>(
                // initState: (_) => LoginController.to.initState(),
                builder: (value) => KeyboardActions(
                    tapOutsideBehavior: TapOutsideBehavior.none,
                    config: KeyboardActionsConfig(
                      nextFocus: true,
                      defaultDoneWidget: const DoneWidget(),
                      actions: focusNodes.map((focusNode) => KeyboardActionsItem(focusNode: focusNode)).toList(),
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: SingleChildScrollView(
                          child: Obx(
                            () => Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 150),
                                  const Center(child: AppLogoWidget()),
                                  Container(height: 50),
                                  Text(
                                    'Welcome Back!',
                                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
                                  ),
                                  Text(
                                    'Sign in with your Username and Password',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                  Container(height: 50),
                                  CommonComponents.defaultTextField(
                                    context,
                                    title: 'Username',
                                    hintText: 'Enter Username',
                                    focusNode: Platform.isIOS ? focusNodes[0] : null,
                                    controller: controller.userNameController,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9" "]'))],
                                    validator: (String? val) {
                                      if (val == '') {
                                        return 'Please enter a valid  username';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onChange: (val) {
                                      // controller.loginButton();
                                    },
                                  ),
                                  Container(height: 20),
                                  CommonComponents.defaultTextField(
                                    context,
                                    title: 'Password',
                                    hintText: 'Enter Password',
                                    focusNode: Platform.isIOS ? focusNodes[1] : null,
                                    obscureText: controller.obscureText,
                                    controller: controller.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    validator: (String? val) {
                                      if (val == '' || val!.length < 3) {
                                        return 'Please enter a valid password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChange: (val) {},
                                    suffixIcon: IconButton(
                                        color: Colors.grey,
                                        icon: Icon(
                                          controller.obscureText ? Icons.visibility_off : Icons.visibility,
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () async {
                                          setState(() {
                                            controller.obscureText = !controller.obscureText;
                                          });
                                        }),
                                  ),
                                  Container(height: 30),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: MaterialButton(
                                        minWidth: MediaQuery.of(context).size.width,
                                        height: 50,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            // Get.toNamed(Routes.selectRetailersView);
                                            controller.loginServiceCall();
                                            // formKey.currentState?.reset();
                                          }
                                        },
                                        child: Text('Login'.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])))));
  }
}
