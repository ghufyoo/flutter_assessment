

import 'package:flutter/material.dart';


class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key,
  required this.mobile,
  required this.tablet,
  required this.desktop,
  required this.infinity
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget infinity;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        if(constraints.maxWidth <= 460){
            return mobile;
        }else if(constraints.maxWidth > 460 && constraints.maxWidth <= 800) {
            return tablet;
        }else if(constraints.maxWidth > 800 && constraints.maxWidth < 1920) {
            return desktop;
        }else{
          return infinity;
        }
      });
  }
}