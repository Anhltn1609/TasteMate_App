import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_bloc.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_event.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';

class ListItemOrder extends StatelessWidget {
  final List<CartDetailsDTO> cartDetails;

  const ListItemOrder({required this.cartDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cartDetails.length == 0)
      return SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Giỏ hàng của bạn đang trống ",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppStyles.primaryColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.home);
              },
              icon: Icon(
                Icons.add_circle,
                color: AppStyles.primaryColor,
                size: 80,
              ),
            ),
          ],
        ),
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Danh sách đơn hàng của bạn",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppStyles.primaryColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartDetails.length,
          itemBuilder: (context, index) {
            final cartDetail = cartDetails[index];

            return Dismissible(
              key: ValueKey(cartDetail.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                context.read<CartBloc>().add(RemoveIngredientsFromCartEvent(
                    cartDetail.ingredient.id, cartDetail.quantity));
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.ingredientDetail,
                      arguments: cartDetail.ingredient.id);
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Image of the item
                        Image.network(
                          cartDetail.ingredient.image,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.image_not_supported,
                            size: 60,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Item name and quantity
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartDetail.ingredient.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('x${cartDetail.quantity}'),
                            ],
                          ),
                        ),
                        // Quantity controls
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (cartDetail.quantity > 1) {
                                  context.read<CartBloc>().add(
                                      RemoveIngredientFromCartEvent(
                                          cartDetail.ingredient.id));
                                }
                              },
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                            ),
                            Text(
                              '${cartDetail.quantity}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                    AddIngredientToCartEvent(
                                        cartDetail.ingredient.id));
                              },
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        Text(
                          '${cartDetail.subtotal}đ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
