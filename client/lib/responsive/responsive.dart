import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.table,
    required this.mobile,
    required this.desktop,
  });
  final Widget table;
  final Widget mobile;
  final Widget desktop;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 650;
  }

  static bool isTable(BuildContext context) {
    return MediaQuery.of(context).size.width >= 650 && MediaQuery.of(context).size.width < 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth < 650) {
          return mobile;
        } else if(constraints.maxWidth >= 650 && constraints.maxWidth < 1100) {
          return table; 
        } else {
          return desktop;
        }
      },
    );
  }
}