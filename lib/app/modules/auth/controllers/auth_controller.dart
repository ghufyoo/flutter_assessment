import 'package:flutter/material.dart';
import 'package:flutter_starter_template/app/routes/app_pages.dart';
import 'package:flutter_starter_template/core/helper/helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final isEmailCorrect = false.obs;
  final hidePassword = true.obs;
  final isPasswordCorrect = false.obs;

  final count = 0.obs;

  @override
  void onReady() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');

    if (email == null) {
    } else {
      Get.offNamed(Routes.HOME);
    }
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  login(BuildContext context) async {
    focusScopeHelper(context);
    if (isEmailCorrect.value != false && isPasswordCorrect.value != false) {
      Get.offNamed(Routes.HOME);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', emailController.value.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid format of email and password'),
      ));
    }
  }
}
