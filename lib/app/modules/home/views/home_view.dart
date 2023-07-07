import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/helper/helper.dart';
import 'package:flutter_starter_template/core/responsive_layout/responsive_widget.dart';
import 'package:flutter_starter_template/core/screens/image.view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: GestureDetector(
          onTap: () => focusScopeHelper(context),
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () => controller.logout(),
                      icon: const Icon(Icons.logout_rounded))
                ],
              ),
              body: Obx(() => SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Flutter Problem No 2",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    'Create a Flutter app that fetches data from an API endpoint and displays it in a list view.',
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        controller.statusCode.value == StatusCode.loading
                            ? const Center(child: CircularProgressIndicator())
                            : controller.statusCode.value == StatusCode.error
                                ? const Center(child: Icon(Icons.error))
                                : Column(
                                    children: [
                                      ...controller.goRestUser
                                          .map((element) => ListTile(
                                                title: Text(element.name),
                                                subtitle: Text(
                                                    element.status.toString()),
                                              )),
                                    ],
                                  ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Flutter Problem No 3",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    'Implement a Flutter counter app that increments and decrements a number when corresponding buttons are pressed.',
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      controller.count.value--;
                                    },
                                    icon: const Icon(Icons.remove))),
                            Text(controller.count.toString()),
                            Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      controller.count.value++;
                                    },
                                    icon: const Icon(Icons.add)))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Flutter Problem No 4",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    "Design a Flutter app that captures an image using the device's camera and displays it on the screen.",
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              children: [
                                InkWell(
                                  onTap: () => controller.getImages(context),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200),
                                    child: const Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                                ...controller.evidenceAttachment
                                    .asMap()
                                    .map((key, value) => MapEntry(
                                        key,
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ImageView(
                                                imgList: controller
                                                    .evidenceAttachment,
                                                index: key,
                                                projectName: "Images"));
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(value))),
                                          ),
                                        )))
                                    .values
                                    .toList()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Flutter Problem No 5",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    "Develop a Flutter app that calculates and displays the factorial of a given number.",
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.factorialTextEditor,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) async {
                                    controller.factorialnumber.value =
                                        controller.factorial(
                                            int.tryParse(_.toString()) ?? 0);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Enter the number"),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                      "factorial of ${controller.factorialTextEditor.text.isEmpty ? 0 : controller.factorialTextEditor.text} is ${controller.factorialnumber.value}")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Logical Problem No 1",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    "Write a function in Dart that checks whether a given string is a palindrome or not.",
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.palindromeTextEditor,
                                  onChanged: (_) async {
                                    final isCorrect =
                                        controller.isPalindrome(_);
                                    if (isCorrect) {
                                      controller.isTextPalindrome.value = true;
                                    } else {
                                      controller.isTextPalindrome.value = false;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Enter any text"),
                                ),
                              ),
                              Expanded(
                                  child: Text(controller.isTextPalindrome.value
                                      ? "is Palindrome"
                                      : "is not Palindrome")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Logical Problem No 2 & 3",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message: '''
2) Implement a function that finds the largest and smallest number in an unsorted list of
integers.
3) Given an array of integers, write a function that returns the second-largest number.
''',
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Column(
                          children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 1),
                                  child: Text("List of random numbers : "),
                                )),
                            Obx(() => Wrap(
                                  children: [
                                    ...controller.listOfRandomNumbers
                                        .map((e) => Text("$e, "))
                                  ],
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              child: Row(
                                children: [
                                  Expanded(
                                      child:
                                          Text("Smallest : ${controller.min}")),
                                  Expanded(
                                      child:
                                          Text("Largest : ${controller.max}"))
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 1),
                                  child: Text(
                                      "Second Largest : ${controller.secondLargest.value}"),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          const Center(child: Text("Shuffle"))),
                                  onPressed: () {
                                    controller.generateRandomList(10, 0, 100);
                                  },
                                ),
                                TextButton(
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text("Min/Max number"))),
                                  onPressed: () {
                                    controller.findMinMax(
                                        controller.listOfRandomNumbers);
                                  },
                                ),
                                TextButton(
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text("2nd largest number"))),
                                  onPressed: () {
                                    controller.findSecondLargest(
                                        controller.listOfRandomNumbers);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Logical Problem No 4",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    "Create a function that determines if a given string is an anagram of another string.",
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller.anagramTextEditor,
                                      decoration: const InputDecoration(
                                          hintText: "Enter any text"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: controller.anagramTextEditor2,
                                      decoration: const InputDecoration(
                                          hintText: "Enter any text"),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text("Anagram Checker"))),
                                onPressed: () {
                                  controller.isAnagram(
                                      controller.anagramTextEditor.text,
                                      controller.anagramTextEditor2.text);
                                },
                              ),
                              controller.anagramTextEditor.text.isNotEmpty &&
                                      controller
                                          .anagramTextEditor2.text.isNotEmpty
                                  ? Text(controller.isTextAnagram.value
                                      ? " is Anagram "
                                      : " is not Anagram")
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                "Logical Problem No 5",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                message:
                                    "Write a recursive function to calculate the nth Fibonacci number in Dart.",
                                child: Icon(Icons.info),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.fibonaciTextEditor,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) async {
                                    controller.fibNum.value = controller
                                        .fibonacci(int.tryParse(controller
                                                .fibonaciTextEditor.text) ??
                                            0);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Enter any text"),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                      "Fibonacci Number = ${controller.fibNum.value}")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text("End of questions",
                            style: GoogleFonts.acme(color: Colors.black12)),
                        SizedBox(
                          height: Get.height * 0.1,
                        )
                      ],
                    ),
                  ))),
        ),
        tablet: Scaffold(
          appBar: AppBar(
            title: const Text('TABLET'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        desktop: Scaffold(
          appBar: AppBar(
            title: const Text('DESKTOP'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        infinity: Scaffold(
          appBar: AppBar(
            title: const Text('4k'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}
