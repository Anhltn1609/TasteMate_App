import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/widgets/dialog_widget.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_bloc.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_event.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_bloc.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_event.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_state.dart';

class IngredientDetailPage extends StatefulWidget {
  final String ingredientId;

  const IngredientDetailPage({super.key, required this.ingredientId});

  @override
  State<IngredientDetailPage> createState() => _IngredientDetailPageState();
}

class _IngredientDetailPageState extends State<IngredientDetailPage> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    context
        .read<IngredientDetailBloc>()
        .add(LoadIngredientDetailEvent(widget.ingredientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết sản phẩm",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
      ),
      body: BlocBuilder<IngredientDetailBloc, IngredientDetailState>(
        builder: (context, state) {
          if (state is IngredientLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IngredientFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is IngredientDetailLoaded) {
            final ingredient = state.ingredient;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Price
                    Center(
                      child: Image.network(
                        ingredient.image ?? AppConfigs.fakeUrl,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Title
                    Text(
                      ingredient.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Giá : ${ingredient.price} đ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    Row(
                      children: [
                        const Icon(Icons.monitor_weight, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                            "Khối lượng : ${ingredient.stockQuantity / 1000} ${ingredient.unit}"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.supplierDetail,
                            arguments: {
                              'id': ingredient.supplier,
                              'name': 'name',
                            });
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.store, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("Nhà cung cấp"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Wishlist Button

                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (quantity > 1) {
                                quantity--;
                                setState(() {});
                              }
                            },
                            child: const Text(
                              "-",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(40, 40),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "$quantity",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Button tăng số lượng
                          ElevatedButton(
                            onPressed: () {
                              quantity++;
                              setState(() {});
                            },
                            child: const Text(
                              "+",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(40, 40),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Button thêm vào giỏ hàng
                          ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                  AddIngredientsToCartEvent(
                                      ingredient.id, quantity));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogWidget(
                                    message:
                                        "Thành công thêm ${ingredient.name} vào giỏ hàng",
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Thêm vào giỏ hàng",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyles.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Information
                    const Text(
                      "Thông tin sản phẩm",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ingredient.description ?? "Chưa có mô tả sản phẩm.",
                      style: const TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
