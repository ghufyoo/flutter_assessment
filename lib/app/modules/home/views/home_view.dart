import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/responsive_layout/responsive_widget.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: Scaffold(
          appBar: AppBar(
            title: const Text('MOBILE'),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
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
