import 'package:flutter/material.dart';
import 'package:tastemate_app/feature/home/views/home_page.dart';

class Routes {
  static const home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
  };
}
