import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/dashboard/view/Ingredient_list.dart';
import 'package:tastemate_app/feature/dashboard/view/Recommended_dish.dart';
import 'package:tastemate_app/feature/dashboard/view/banner_carousel.dart';
import 'package:tastemate_app/feature/dashboard/view/nutrition_summary_widget.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_bloc.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_event.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_bloc.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_event.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DiscoveryBloc>().add(LoadIngredientsEvent());
    context.read<RecipeBloc>().add((LoadRecipesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TasteMate",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerCarousel(),
            SizedBox(height: 16),
            RecommendedMealSection(),
            SizedBox(height: 16),
            IngrdientSection(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Nutrition Summary History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            NutritionSummaryWidget(),
          ],
        ),
      ),
    );
  }
}
