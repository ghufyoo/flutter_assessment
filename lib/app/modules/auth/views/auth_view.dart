import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_template/core/helper/helper.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          focusScopeHelper(context);
        },
        child: SingleChildScrollView(
          child:Obx(()=> Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  'Welcome to Flutter Assessment done by Ghufran ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.width * 0.9,
                child: Text(
                  'Please enter your registration email and password.',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^ '),
                    ),
                  ],
                  controller: controller.emailController.value,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (value.isEmpty || !regex.hasMatch(value)) {
                      controller.isEmailCorrect.value = false;
                    } else {
                      controller.isEmailCorrect.value = true;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: GoogleFonts.openSans(color: Colors.black45),
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffixIcon: Obx(
                          () => controller.emailController.value.text.isNotEmpty
                              ? controller.isEmailCorrect.value == true
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.amber,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.red,
                                    )
                              : const SizedBox.shrink()),
                      errorText: null,
                      errorStyle: GoogleFonts.lato(
                          color: Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      border: const OutlineInputBorder()),
                  style: GoogleFonts.openSans(
                      fontSize: 10, color: Colors.black, letterSpacing: 0.8),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(r'^ '),
                      ),
                    ],
                    controller: controller.passwordController.value,
                    obscureText: controller.hidePassword.value,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value.isEmpty || value.length < 6) {
                        controller.isPasswordCorrect.value = false;
                      } else {
                        controller.isPasswordCorrect.value = true;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: GoogleFonts.openSans(color: Colors.black45),
                        prefixIcon: const Icon(Icons.lock),
                        errorText:
                            controller.passwordController.value.text.isNotEmpty
                                ? controller.isPasswordCorrect.value == true
                                    ? null
                                    : "Password must be more than 6 character"
                                : null,
                        suffixIcon: Obx(() => Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                controller.passwordController.value.text
                                        .isNotEmpty
                                    ? controller.isPasswordCorrect.value == true
                                        ? const Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.amber,
                                          )
                                        : const Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.red,
                                          )
                                    : const SizedBox.shrink(),
                                InkWell(
                                  onTap: () => controller.hidePassword.value =
                                      !controller.hidePassword.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: controller.hidePassword.value == true
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  ),
                                )
                              ],
                            )),
                        errorStyle: GoogleFonts.lato(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        border: const OutlineInputBorder()),
                    style: GoogleFonts.openSans(
                        fontSize: 10, color: Colors.black, letterSpacing: 0.8),
                  )),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => controller.login(context),
                child: ClipRRect(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.openSans(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          )  ),
      ),
    );
  }
}
