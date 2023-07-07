import 'dart:developer';
import 'dart:io';
import 'dart:math' as m;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_template/app/data/models/gorest_user.model.dart';
import 'package:flutter_starter_template/app/data/repository/gorest/gorest_repository_impl.dart';
import 'package:flutter_starter_template/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/bottomsheet/attachment.bottomsheet.dart';

class HomeController extends GetxController {
  HomeController({required this.goRestRepositoryImpl});
  final GoRestRepositoryImpl goRestRepositoryImpl;
  final goRestUser = <GoRestUserModel>[].obs;
  final evidenceAttachment = <File>[].obs;
  final statusCode = StatusCode.loading.obs;
  final factorialTextEditor = TextEditingController();
  final palindromeTextEditor = TextEditingController();
  final anagramTextEditor = TextEditingController();
  final anagramTextEditor2 = TextEditingController();
  final fibonaciTextEditor = TextEditingController();
  final count = 0.obs;
  final min = 0.obs;
  final max = 0.obs;

  final secondLargest = 0.obs;
  final factorialnumber = 0.obs;
  final isTextPalindrome = false.obs;
  final isTextAnagram = false.obs;
  final listOfRandomNumbers = <int>[].obs;
  final listOfFibonacciSequence = <int>[].obs;

  @override
  void onInit() {
    loadUserData();
    generateRandomList(10, 0, 100);
    super.onInit();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  loadUserData() async {
    try {
      statusCode.value = StatusCode.loading;
      final data = await goRestRepositoryImpl.getGoRestUserData();
      goRestUser.addAll(data);
      statusCode.value = StatusCode.success;
    } catch (e) {
      statusCode.value = StatusCode.error;
      log(e.toString());
    }
  }

  Future getImages(BuildContext context) async {
    final data = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => const AttachmentBottomsheet(
        needFromFile: true,
        multiple: true,
      ),
    );
    if (data == null) return;
    if (data is List<File>) {
      evidenceAttachment.addAll(data);
    } else {
      evidenceAttachment.add(data);
    }
  }

  int factorial(int n) {
    if (n == 0) {
      return 1;
    } else {
      return n * factorial(n - 1);
    }
  }

  bool isPalindrome(String text) {
    String reversedText = text.split('').reversed.join('');
    return text == reversedText;
  }

  generateRandomList(int length, int min, int max) {
    listOfRandomNumbers.clear();
    m.Random random = m.Random();
    List<int> randomList = [];

    for (int i = 0; i < length; i++) {
      int randomNumber = min + random.nextInt(max - min + 1);
      randomList.add(randomNumber);
    }
    listOfRandomNumbers.addAll(randomList);
  }

  void findMinMax(List<int> numbers) {
    if (numbers.isEmpty) {
      return;
    }

    final maximum = numbers.reduce((a, b) => a > b ? a : b);
    final minimum = numbers.reduce((a, b) => a < b ? a : b);
    max.value = maximum;
    min.value = minimum;
  }

  void findSecondLargest(List<int> numbers) {
    numbers.sort((a, b) => b.compareTo(a));
    final secondLar = numbers[1];
    secondLargest.value = secondLar;
  }

  isAnagram(String str1, String str2) {
    if (str1.length != str2.length) {
      return false;
    }

    List<String> chars1 = str1.split('');
    List<String> chars2 = str2.split('');

    chars1.sort();
    chars2.sort();

    bool isAnagram = listEquals(chars1, chars2);
    isTextAnagram.value = isAnagram;
  }

  fibonacciSequence(int n) {
    listOfFibonacciSequence.clear();
    if (n == 1) {
      listOfFibonacciSequence.addAll([0]);
      return;
    }
    if (n <= 0) {
      return;
    }
    List<int> na = [0, 1];
    while (n > na.length) {
      int last = na.last;

      int secondLast = na[na.length - 2];

      na.add(last + secondLast);
    }

    listOfFibonacciSequence.addAll(na);
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    Get.offNamed(Routes.AUTH);
  }
}

enum StatusCode { loading, success, error }
