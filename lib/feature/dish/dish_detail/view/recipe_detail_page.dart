// recipe_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_bloc.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_event.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_state.dart';
import 'package:tastemate_app/feature/dish/dish_detail/model/dish_recipe_dto.dart';

class RecipeDetailPage extends StatefulWidget {
  final String dishId;

  const RecipeDetailPage({super.key, required this.dishId});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DishDetailBloc>().add(LoadRecipesDetailEvent(widget.dishId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Details')),
      body: BlocBuilder<DishDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecipeDetailLoaded) {
            final dish = state.dishWithIngredientsDTO;
            return DishDetailView(dish: dish);
          } else if (state is RecipeDetailError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class DishDetailView extends StatelessWidget {
  final DishWithIngredientsDTO dish;

  const DishDetailView({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String outputText = dish.dish.recipe.replaceAll("\\n", "\n\n");
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dish Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              dish.dish.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),

          // Dish Name
          Text(
            dish.dish.name,
            style: const TextStyle(
                fontSize: 24,
                color: AppStyles.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),

          // Description
          Text(
            dish.dish.description,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),

          // Recipe
          Text(
            "Recipe:",
            style: const TextStyle(
                fontSize: 22,
                color: AppStyles.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),

          Text(
            outputText,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16.0),

          // Ingredients Section
          Text(
            "Ingredients:",
            style: const TextStyle(
                fontSize: 24,
                color: AppStyles.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ...dish.quantityDTO.map((quantityDTO) => ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    quantityDTO.ingredient.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  quantityDTO.ingredient.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                    "Số lượng : ${quantityDTO.quantity} ${quantityDTO.ingredient.unit} \nGiá trị dinh dưỡng: ${quantityDTO.ingredient.nutritionalValue} kcal"),
              )),
        ],
      ),
    );
  }
}
