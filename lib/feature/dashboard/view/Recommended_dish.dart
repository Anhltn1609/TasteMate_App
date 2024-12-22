import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_bloc.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_state.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';

class RecommendedMealSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RecipeLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recommended Meal Plans',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 146,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.dishes
                      .map((dish) => _buildMealCard(dish, context))
                      .toList(),
                ),
              ),
            ],
          );
        } else if (state is RecipeError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildMealCard(DishDTO dish, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.dishDetail, arguments: dish.id);
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(AppConfigs.fakeUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              dish.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
