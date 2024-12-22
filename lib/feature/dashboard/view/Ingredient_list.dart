import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_bloc.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_state.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_state.dart';

class IngrdientSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoveryBloc, DiscoveryState>(
      builder: (context, state) {
        if (state is DiscoveryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is IngredientsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Danh sách nguyên liệu yêu thích',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 146,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.ingredients
                      .map((meal) => _buildMealCard(meal.name))
                      .toList(),
                ),
              ),
            ],
          );
        } else if (state is DiscoveryFailure) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildMealCard(String title) {
    return Container(
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
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
