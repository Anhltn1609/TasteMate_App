import 'package:flutter/material.dart';
import 'package:tastemate_app/feature/discovery/view/brand_detail_page.dart';
import 'package:tastemate_app/feature/discovery/view/category_detail_page.dart';
import 'package:tastemate_app/feature/discovery/view/product_detail_page.dart';
import 'package:tastemate_app/feature/home/views/home_page.dart';
import 'package:tastemate_app/feature/profile/view/profile_page.dart';
import 'package:tastemate_app/feature/recipes/view/component/recipe_detail_widget.dart';

class Routes {
  static const home = '/home';
  static const profile = '/profile';
  static const productDetail = '/productDetail';
  static const brandDetail = '/BrandDetail';
  static const categoryDetail = '/categoryDetail';
  static const recipeDetail = '/recipeDetail';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    profile: (context) => const ProfilePage(),
    productDetail: (context) => ProductDetailPage(
        productId: ModalRoute.of(context)!.settings.arguments as int),
    brandDetail: (context) =>
        BrandDetail(brandId: ModalRoute.of(context)!.settings.arguments as int),
    categoryDetail: (context) => CategoryDetailPage(
        categoryId: ModalRoute.of(context)!.settings.arguments as int),
    recipeDetail: (context) => RecipeDetailWidget(
        recipeId: ModalRoute.of(context)!.settings.arguments as int),
  };
}
