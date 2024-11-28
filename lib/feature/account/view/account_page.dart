import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account '),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anne Jone',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('21 years'),
                    Text('Current weight: 60 kg'),
                    Text('Goal: Lose Weight'),
                    Text('Active Diet: Lifesum Standard'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Options and Settings
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Your Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Reward Program'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.wallet),
              title: Text('Your Wallet'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Refer a Friend'),
              subtitle: Text('Get 50,000₫ when your friend joins!'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Details'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address'),
              onTap: () {},
            ),
            Divider(),

            // Customization
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Customization',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.tune),
              title: Text('Adjust Macronutrients'),
              subtitle: Text('Carbs, fat, and protein'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.fireplace),
              title: Text('Adjust Calories'),
              subtitle: Text('1378 kcal/day'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Dietary Needs & Preferences'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.water),
              title: Text('Water Habits'),
              onTap: () {},
            ),

            // Additional Options
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('Contact'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
