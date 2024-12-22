import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_bloc.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_event.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_state.dart';
import 'package:tastemate_app/feature/authenication/model/user_dto.dart';

class ProfilePage extends StatelessWidget {
  final UserDTO UserInfor = ApiService.user;
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).profile,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
        actions: [
          // Todo : Add Dialog help customer center
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: AppStyles.primaryColor,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  App.setLocale(context, _locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.headset_mic,
              color: AppStyles.primaryColor,
            ),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Information
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(AppConfigs.fakeUrl),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UserInfor.fullname,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(AppLocalizations.of(context)
                            .age_information_profile(21)),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).current_weight),
                            const Spacer(),
                            Text(
                              '60 kg',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).goal),
                            const Spacer(),
                            Text(
                              'Lose Weight',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context).profile_title_oder_setting,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.primaryColor),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(
                  AppLocalizations.of(context).your_orders,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  AppLocalizations.of(context).notifications,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context).profile_title_personal_setting,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.primaryColor),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  AppLocalizations.of(context).personal_details,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.userInfor);
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  AppLocalizations.of(context).address,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.fireplace),
                title: Text(
                  AppLocalizations.of(context).adjust_calories,
                ),
                subtitle: Text(
                  AppLocalizations.of(context).adjust_calories_subtitle,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text(
                  AppLocalizations.of(context).dietary_needs_preferences,
                ),
                onTap: () {},
              ),
              // Additional Options
              const SizedBox(height: 20),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context).profile_title_others_setting,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.primaryColor),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  AppLocalizations.of(context).settings,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  AppLocalizations.of(context).logout,
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Xác nhận thoát'),
                      content: const Text(
                          'Bạn có chắc chắn muốn thoát khỏi ứng dụng không?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Không'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLogout());
                            // Navigator.of(context).pop(true);
                          },
                          child: const Text('Có'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  AppLocalizations.of(context).help,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
