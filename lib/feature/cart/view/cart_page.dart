import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/core/widgets/green_button_widget.dart';
import 'package:tastemate_app/feature/cart/view/component/list_item_oder.dart';
import 'package:tastemate_app/feature/cart/view/component/order_summary_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cart,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.network(
                  ApiService.user.avatar ?? AppConfigs.fakeUrl,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person,
                        color: Colors.grey[700], size: 30);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green[100],
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rate,
                    size: 28,
                    color: AppStyles.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .free_shipping_message_part1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: '129.000đ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .free_shipping_message_part2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.5,
                          color: AppStyles.primaryColor,
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),
            // Cart Items List
            ListItemOrder(),
            // Order Summary
            const OrderSummary(),
            // Place Order Button
            GreenButtonWidget(
              onPressed: () {
                // Todo: Navigate to Payment
              },
              title: translation(context).place_order,
              isDisabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
