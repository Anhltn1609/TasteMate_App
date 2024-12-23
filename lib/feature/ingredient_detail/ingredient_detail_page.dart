import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
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
  @override
  void initState() {
    super.initState();
    final ingredientDetailBloc = context.read<IngredientDetailBloc>();
    ingredientDetailBloc.add(LoadIngredientDetailEvent(widget.ingredientId));
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
                      child: Column(
                        children: [
                          Image.network(
                            ingredient.image ?? AppConfigs.fakeUrl,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${ingredient.price} đ",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Title
                    Text(
                      ingredient.name ?? "Tên sản phẩm",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Product Details
                    Row(
                      children: const [
                        Icon(Icons.flag, color: Colors.grey),
                        SizedBox(width: 8),
                        Text("Xuất xứ: Việt Nam"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.store, color: Colors.grey),
                        SizedBox(width: 8),
                        Text("Thương hiệu: Rice Color"),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Wishlist Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
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
