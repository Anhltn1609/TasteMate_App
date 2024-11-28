import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';

class GreenButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool isDisabled;

  GreenButtonWidget({
    required this.onPressed,
    required this.title,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey : Colors.green,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
