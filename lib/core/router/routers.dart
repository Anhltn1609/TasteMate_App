import 'package:flutter/material.dart';
import 'package:tastemate_app/feature/authenication/view/forgot_password_page.dart';
import 'package:tastemate_app/feature/authenication/view/login_page.dart';
import 'package:tastemate_app/feature/authenication/view/register_page.dart';
import 'package:tastemate_app/feature/authenication/view/resset_password.dart';
import 'package:tastemate_app/feature/authenication/view/verify_otp_page.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';
import 'package:tastemate_app/feature/dashboard/dashboard_page.dart';
import 'package:tastemate_app/feature/discovery/view/discovery_page.dart';
import 'package:tastemate_app/feature/dish/dish_detail/view/recipe_detail_page.dart';
import 'package:tastemate_app/feature/ingredient/view/category_detail_page.dart';
import 'package:tastemate_app/feature/home/views/home_page.dart';
import 'package:tastemate_app/feature/ingredient/view/supplier_Ingredient_page.dart';
import 'package:tastemate_app/feature/ingredient_detail/ingredient_detail_page.dart';
import 'package:tastemate_app/feature/order/view/order_page.dart';
import 'package:tastemate_app/feature/profile/view/profile_page.dart';
import 'package:tastemate_app/feature/profile/view/user_infor_page.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const verifyOtp = '/verifyOtp';
  static const forgotPassword = '/forgotPassword';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const discoveryPage = '/discoveryPage';
  static const profile = '/profile';
  static const orderPage = '/orderPage';
  static const ingredientDetail = '/ingredientDetail';
  static const categoryDetail = '/categoryDetail';
  static const supplierDetail = '/supplierDetail';
  static const dishDetail = '/dishDetail';
  static const userInfor = '/userInfor';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    profile: (context) => ProfilePage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    resetPassword: (context) => ResetPasswordPage(
        email: ModalRoute.of(context)!.settings.arguments as String),
    forgotPassword: (context) => const ForgotPasswordPage(),
    dashboard: (context) => DashboardPage(),
    orderPage: (context) => OrderPage(
        selectedCartDetails:
            ModalRoute.of(context)!.settings.arguments as List<CartDetailsDTO>),
    discoveryPage: (context) => const DiscoveryPage(),
    userInfor: (context) => const UserInforPage(),
    verifyOtp: (context) => VerifyOtpPage(
        email: ModalRoute.of(context)!.settings.arguments as String),
    categoryDetail: (context) => CategoryDetailPage(
        categoryId: ModalRoute.of(context)!.settings.arguments as String),
    supplierDetail: (context) => SupplierIngredientPage(
          supplierId: (ModalRoute.of(context)!.settings.arguments
              as Map<String, String>)['id']!,
          title: (ModalRoute.of(context)!.settings.arguments
              as Map<String, String>)['name']!,
        ),
    dishDetail: (context) => RecipeDetailPage(
        dishId: ModalRoute.of(context)!.settings.arguments as String),
    ingredientDetail: (context) => IngredientDetailPage(
        ingredientId: ModalRoute.of(context)!.settings.arguments as String),
  };
}
