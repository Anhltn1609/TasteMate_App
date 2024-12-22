import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_event.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_state.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;

  const CategoryDetailPage({super.key, required this.categoryId});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<IngredientBloc>()
        .add(LoadCategoryDetailEvent(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Category Details",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: AppStyles.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic, color: Colors.black),
            onPressed: () {
              // Handle helpdesk navigation
            },
          ),
        ],
      ),
      body: BlocListener<IngredientBloc, IngredientState>(
        listener: (context, state) {
          if (state is IngredientFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<IngredientBloc, IngredientState>(
          builder: (context, state) {
            if (state is IngredientLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryDetailLoaded) {
              return CategoryListWidget(
                title: "Ingredients",
                ingredients: state.ingredients,
              );
            } else if (state is IngredientFailure) {
              return Center(
                child: Text(
                  "Failed to load details.",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Unknown state.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  final List<IngredientDTO> ingredients;
  final String title;

  const CategoryListWidget({
    super.key,
    required this.ingredients,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.textBold,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return IngredientCard(ingredient: ingredients[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final IngredientDTO ingredient;

  const IngredientCard({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text(ingredient.name)),
              body: Center(child: Text("Ingredient details page")),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(ingredient.image, height: 100, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              ingredient.unit,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              '${ingredient.price} đ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              ingredient.name,
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Handle add to cart
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                "+ Add to cart",
                style: TextStyle(color: AppStyles.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
