import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  buildRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => this,
    );
  }
}
