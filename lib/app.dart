import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_keys.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/utils/view_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Define routers, themes
class App extends StatelessWidget with ViewUtils {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TasteMate',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppKeys.navigatorKey,
      scaffoldMessengerKey: AppKeys.snackBarKey,
      routes: Routes.routes,
      initialRoute: Routes.home,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppStyles.primaryColor),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: child,
        );
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
