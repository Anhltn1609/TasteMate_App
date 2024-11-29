import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(translation(context).helloWorld),
        // Text('This is dashboardPage'),
      ),
    );
  }
}
