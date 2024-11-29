import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(translation(context).total_amount,
                  style: const TextStyle(fontSize: 16)),
              Spacer(),
              const Text('171,000đ', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(translation(context).shipping_fee,
                  style: const TextStyle(fontSize: 16)),
              Spacer(),
              const Text('30,000đ', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Promo code functionality here
            },
            child: Row(
              children: [
                Spacer(),
                Text(translation(context).apply_discount_code,
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: translation(context).delivery_address_description,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
