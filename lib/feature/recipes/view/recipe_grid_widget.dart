import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/recipes/model/recipe.dart';

final List<Recipe> listRecipe = [
  Recipe(
    title: 'Lavender and Lemon Granola',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 192,
  ),
  Recipe(
    title: 'Oatmeal Breakfast Bread',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 152,
  ),
  Recipe(
    title: 'Carrot Salad With Peanut Butter Dressing',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 146,
  ),
  Recipe(
    title: 'Carrot Salad with Sesame Dressing',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 224,
  ),
  Recipe(
    title: 'Lavender and Lemon Granola',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 192,
  ),
  Recipe(
    title: 'Oatmeal Breakfast Bread',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 152,
  ),
  Recipe(
    title: 'Carrot Salad With Peanut Butter Dressing',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 146,
  ),
  Recipe(
    title: 'Carrot Salad with Sesame Dressing',
    imageUrl: 'https://via.placeholder.com/150',
    calories: 224,
  ),
];

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SearchBar(),
          RecipeGrid(
            title: translation(context).whats_hot,
            recipes: listRecipe.sublist(0, 8),
            childAspectRatio: 0.9,
          ),
          RecipeGrid(
            title: translation(context).morning,
            recipes: listRecipe.sublist(0, 8),
            childAspectRatio: 1.35,
          ),
          RecipeGrid(
            title: translation(context).lunch,
            recipes: listRecipe.sublist(0, 8),
            childAspectRatio: 1.35,
          ),
        ],
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final String title;
  final double childAspectRatio;
  const RecipeGrid(
      {super.key,
      required this.recipes,
      required this.title,
      required this.childAspectRatio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(
          height: 240,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            // physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 12,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.recipeDetail,
                      arguments: index);
                },
                child: RecipeItem(recipe: recipes[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(AppConfigs.fakeUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${recipe.calories} kcal',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: translation(context).find_recipes,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.filter_list,
            color: Colors.green,
            size: 24,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //Todo : Navigate to SectionDetail
            },
            child: Text(
              translation(context).see_all,
              style: TextStyle(color: AppStyles.primaryColor, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
