import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_bloc.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_event.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_state.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Recipes',
          style:
              const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => RecipeBloc(ApiService())..add(LoadRecipesEvent()),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: DishListView(),
        ),
      ),
    );
  }
}

class DishListView extends StatelessWidget {
  const DishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecipeLoaded) {
          final dishes = state.dishes;
          return ListView(
            children: [
              const SearchBar(),
              DishGrid(
                title: 'Hot Dishes',
                dishes: dishes,
                childAspectRatio: 0.9,
              ),
              DishGrid(
                title: 'Morning',
                dishes: dishes,
                childAspectRatio: 1.35,
              ),
              DishGrid(
                title: 'Lunch',
                dishes: dishes,
                childAspectRatio: 1.35,
              ),
            ],
          );
        } else if (state is RecipeError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("No data available"));
        }
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class DishItem extends StatelessWidget {
  final DishDTO dish;
  const DishItem({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.dishDetail, arguments: dish.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(dish.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${dish.nutritionalValue} kcal',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DishGrid extends StatelessWidget {
  final List<DishDTO> dishes;
  final String title;
  final double childAspectRatio;
  const DishGrid(
      {super.key,
      required this.dishes,
      required this.title,
      required this.childAspectRatio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(
          height: 200,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              return DishItem(dish: dishes[index]);
            },
          ),
        ),
      ],
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
