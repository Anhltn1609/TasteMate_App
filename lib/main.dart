import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_bloc.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_bloc.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_bloc.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_bloc.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_bloc.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_bloc.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_bloc.dart';
import 'package:tastemate_app/feature/order/bloc/order_bloc.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize some services like firebase
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(ApiService()),
        ),
        BlocProvider<UserInforBloc>(
          create: (context) => UserInforBloc(ApiService()),
        ),
        BlocProvider<DiscoveryBloc>(
          create: (context) => DiscoveryBloc(ApiService()),
        ),
        BlocProvider<IngredientBloc>(
          create: (context) => IngredientBloc(ApiService()),
        ),
        BlocProvider<DishDetailBloc>(
          create: (context) => DishDetailBloc(ApiService()),
        ),
        BlocProvider<RecipeBloc>(
          create: (context) => RecipeBloc(ApiService()),
        ),
        BlocProvider<IngredientDetailBloc>(
          create: (context) => IngredientDetailBloc(ApiService()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(ApiService()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(ApiService()),
        ),
        BlocProvider<NutritionHistoryBloc>(
          create: (context) => NutritionHistoryBloc(ApiService()),
        ),
      ],
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}
