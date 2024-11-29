import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/feature/recipes/view/recipe_grid_widget.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            translation(context).lifesum_standard,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: RecipeListView(),
        ),
      ),
    );
  }
}
