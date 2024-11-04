import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';

// Update theme if necessary
class AppTheme {
  AppTheme._();

  static get themeData => ThemeData.light().copyWith(
        //Colors
        scaffoldBackgroundColor: AppStyles.bgLightModeColor,
        primaryColor: AppStyles.primaryColor,
        colorScheme: _colorScheme,

        //Layout
        appBarTheme: _appBarTheme,
        tabBarTheme: _tabBarTheme,
        iconTheme: _iconTheme,
        bottomAppBarTheme: _bottomAppBarTheme,
        bottomNavigationBarTheme: _bottomNavigationBarTheme,
        dialogTheme: _dialogTheme,
        bottomSheetTheme: _bottomSheetTheme,
        drawerTheme: _drawerTheme,

        //Text
        textTheme: _textTheme,
        primaryTextTheme: _textTheme,
        // textSelectionTheme: _textSelectionTheme,
        // inputDecorationTheme: _inputDecorationTheme,

        // //Buttons
        // floatingActionButtonTheme: _floatingActionButtonTheme,
        // elevatedButtonTheme: _elevatedButtonTheme,
        // textButtonTheme: _textButtonTheme,
        // outlinedButtonTheme: _outlinedButtonTheme,

        // //Controls and UI Elements
        // checkboxTheme: _checkboxTheme,
        // radioTheme: _radioTheme,
        // progressIndicatorTheme: _progressIndicatorTheme,
        // snackBarTheme: _snackBarTheme,
        // cardTheme: _cardTheme,
        // dividerTheme: _dividerTheme,
        // chipTheme: _chipTheme,
        // listTileTheme: _listTileTheme,
        // datePickerTheme: _datePickerTheme,
      );

  static ColorScheme get _colorScheme {
    return ColorScheme.fromSeed(seedColor: AppStyles.primaryColor).copyWith(
      primary: AppStyles.primaryColor,
      surface: Colors.white,
      secondary: AppStyles.secondaryColor,
      onPrimary: Colors.black,
      error: AppStyles.errorColor,
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    );
  }

  static TabBarTheme get _tabBarTheme {
    return const TabBarTheme(
      labelColor: AppStyles.primaryColor,
      indicatorColor: AppStyles.primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppStyles.primaryColor,
          width: 2.0,
        ),
      ),
    );
  }

  static IconThemeData get _iconTheme {
    return const IconThemeData(
      color: AppStyles.primaryColor,
    );
  }

  static BottomAppBarTheme get _bottomAppBarTheme {
    return const BottomAppBarTheme(
      color: Colors.white,
      elevation: 2,
    );
  }

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    return const BottomNavigationBarThemeData(
      selectedItemColor: AppStyles.primaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 2,
      backgroundColor: Colors.white,
    );
  }

  static DialogTheme get _dialogTheme {
    return const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
    );
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  static DrawerThemeData get _drawerTheme {
    return const DrawerThemeData(
      backgroundColor: Colors.white,
    );
  }

  //============================================================
  //  TEXT
  //============================================================
  static TextStyle get commonTextStyle => const TextStyle(
        fontSize: AppStyles.fontSizeM,
        color: AppStyles.textColor,
        letterSpacing: 0.25,
      );

  static TextTheme get _textTheme {
    return ThemeData.light().textTheme.copyWith(
          displayLarge: commonTextStyle.copyWith(fontSize: AppStyles.fontSizeL),
          displayMedium: commonTextStyle,
          displaySmall: commonTextStyle.copyWith(fontSize: AppStyles.fontSizeS),
          titleLarge: commonTextStyle.copyWith(fontSize: AppStyles.fontSizeL),
          titleMedium: commonTextStyle,
          titleSmall: commonTextStyle.copyWith(fontSize: AppStyles.fontSizeM),
        );
  }
}
