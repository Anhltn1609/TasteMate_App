import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_event.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_state.dart';

class SupplierIngredientPage extends StatefulWidget {
  final String supplierId;
  final String title;

  const SupplierIngredientPage({
    super.key,
    required this.supplierId,
    required this.title,
  });

  @override
  _SupplierIngredientPageState createState() => _SupplierIngredientPageState();
}

class _SupplierIngredientPageState extends State<SupplierIngredientPage> {
  late List<IngredientDTO> filteredIngredients = [];
  late List<IngredientDTO> allIngredients = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<IngredientBloc>()
        .add(LoadSupplierIngredientEvent(widget.supplierId));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Supplier ${widget.title} Details",
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
              allIngredients = state.ingredients;
              filteredIngredients = filteredIngredients.isEmpty
                  ? allIngredients
                  : filteredIngredients;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (value) {
                        final query = searchController.text.toLowerCase();
                        setState(() {
                          filteredIngredients = allIngredients
                              .where((ingredient) =>
                                  ingredient.name.toLowerCase().contains(query))
                              .toList();
                          print("filteredIngredients : $filteredIngredients");
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: searchController.text,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: filteredIngredients.isEmpty
                          ? Center(
                              child: Text(
                                "No ingredients found.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: filteredIngredients.length,
                              itemBuilder: (context, index) {
                                return IngredientCard(
                                  ingredient: filteredIngredients[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
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

class IngredientCard extends StatelessWidget {
  final IngredientDTO ingredient;

  const IngredientCard({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.ingredientDetail,
          arguments: ingredient.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(ingredient.image, height: 80, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              "${ingredient.stockQuantity / 1000} ${ingredient.unit}",
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
                "Add to cart",
                style: TextStyle(color: AppStyles.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
