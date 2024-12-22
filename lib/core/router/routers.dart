import 'package:flutter/material.dart';
import 'package:tastemate_app/feature/authenication/view/forgot_password_page.dart';
import 'package:tastemate_app/feature/authenication/view/login_page.dart';
import 'package:tastemate_app/feature/authenication/view/register_page.dart';
import 'package:tastemate_app/feature/authenication/view/resset_password.dart';
import 'package:tastemate_app/feature/authenication/view/verify_otp_page.dart';
import 'package:tastemate_app/feature/dashboard/dashboard_page.dart';
import 'package:tastemate_app/feature/dish/dish_detail/view/recipe_detail_page.dart';
import 'package:tastemate_app/feature/ingredient/view/category_detail_page.dart';
import 'package:tastemate_app/feature/discovery/view/product_detail_page.dart';
import 'package:tastemate_app/feature/home/views/home_page.dart';
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
  static const profile = '/profile';
  static const productDetail = '/productDetail';
  static const categoryDetail = '/categoryDetail';
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
    userInfor: (context) => const UserInforPage(),
    productDetail: (context) => ProductDetailPage(
        productId: ModalRoute.of(context)!.settings.arguments as int),
    verifyOtp: (context) => VerifyOtpPage(
        email: ModalRoute.of(context)!.settings.arguments as String),
    categoryDetail: (context) => CategoryDetailPage(
        categoryId: ModalRoute.of(context)!.settings.arguments as String),
    dishDetail: (context) => RecipeDetailPage(
        dishId: ModalRoute.of(context)!.settings.arguments as String),
  };
}
