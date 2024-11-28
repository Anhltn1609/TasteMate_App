import 'package:flutter/material.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/discovery/view/component/brand_tab_widget.dart';
import 'package:tastemate_app/feature/discovery/view/component/product_tab_widget.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Khám phá',
            style: AppStyles.textBold.copyWith(fontSize: 30),
          ),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.account);
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.network(
                    AppConfigs.fakeUrl,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person,
                          color: Colors.grey[700], size: 30);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sản phẩm'),
              Tab(text: 'Thương hiệu'),
            ],
            indicatorColor: AppStyles.primaryColor,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: [
            ProductTab(),
            BrandTab(),
          ],
        ),
      ),
    );
  }
}
