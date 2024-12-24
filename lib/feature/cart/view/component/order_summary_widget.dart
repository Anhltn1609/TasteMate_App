import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';

class OrderSummary extends StatelessWidget {
  final int totalPrice;

  const OrderSummary({required this.totalPrice, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translation(context).total_amount,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '$totalPrice đ',
            style: const TextStyle(
                color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
