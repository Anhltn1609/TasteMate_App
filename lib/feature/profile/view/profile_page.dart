import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(AppConfigs.fakeUrl),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anne Jone',
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
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(
                AppLocalizations.of(context).reward_program,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.wallet),
              title: Text(
                AppLocalizations.of(context).your_wallet,
              ),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                AppLocalizations.of(context).profile_title_personal_setting,
                style: TextStyle(
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                AppLocalizations.of(context).address,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.tune),
              title: Text(
                AppLocalizations.of(context).adjust_macronutrients,
              ),
              subtitle: Text(
                AppLocalizations.of(context).adjust_macronutrients_subtitle,
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
            ListTile(
              leading: Icon(Icons.water),
              title: Text(
                AppLocalizations.of(context).water_habits,
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
              leading: Icon(Icons.help),
              title: Text(
                AppLocalizations.of(context).help,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
