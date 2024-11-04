import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_keys.dart';

mixin ViewUtils {
  get navigatorState => AppKeys.navigatorKey.currentState;

  void unFocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  bool isPortrait(context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait;
  }

  bool isLandscape(context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape;
  }

  void popWithoutContext([dynamic value]) => navigatorState?.pop(value);

  // Navigator with context
  Future<dynamic> push(
    BuildContext context,
    Widget route, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) async {
    if (Platform.isIOS) {
      return Navigator.of(context).push(
        CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => route,
          settings: settings,
        ),
      );
    }
    return Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<dynamic> pushReplacement(BuildContext context, Widget routerName) {
    return Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(builder: (context) => routerName));
  }

  Future<dynamic> pushAndRemoveUntil(BuildContext context, Widget routerName) {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => routerName), (route) => false);
  }

  void pushName(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void safePop(BuildContext context, [dynamic value]) {
    if (context.mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop(value);
    }
  }

  void popUntil(
    BuildContext context,
    String route, {
    bool isFromRootContext = false,
  }) {
    Navigator.of(context).popUntil(ModalRoute.withName(route));
  }

  // Navigate without context
  Future<dynamic>? pushReplacementNamedWithoutContext(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic>? pushReplacementWithoutContext(Widget routerName) {
    return navigatorState?.pushReplacement(
        MaterialPageRoute<dynamic>(builder: (_) => routerName));
  }

  Future<dynamic>? pushNamedAndRemoveUntilWithoutContext(
    String routeName,
    bool Function(Route route) predicate, {
    Object? arguments,
  }) {
    return navigatorState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  Future<void> showSnackBar(
    String title,
    TextStyle? textStyle,
    SnackBarAction? snackBarAction,
  ) async {
    AppKeys.snackBarKey.currentState?.showSnackBar(SnackBar(
      content: Text(
        title,
        style: textStyle,
      ),
      action: snackBarAction,
    ));
  }

  void pushNameWithoutContext(
    String routeName, {
    Object? arguments,
  }) {
    navigatorState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushWithoutContext(
    Widget route, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) async {
    return navigatorState?.push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (_) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  Future<dynamic>? pushAndRemoveUntilWithoutContext(Widget routerName) {
    return navigatorState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => routerName), (route) => false);
  }
}
