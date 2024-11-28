import 'package:flutter/material.dart';

class RecipeDetailWidget extends StatelessWidget {
  final int recipeId;
  const RecipeDetailWidget({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is Recipe detail $recipeId'),
      ),
    );
  }
}
