import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/feature/discovery/view/component/list_product_widget.dart';

class BrandDetail extends StatelessWidget {
  final int brandId;
  const BrandDetail({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(AppConfigs.fakeUrl),
              radius: 50,
            ),
            const SizedBox(height: 16),
            const Text(
              'Tiger',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Bia cao cấp quốc tế số 1 của châu Á\n'
              'Vào năm 1932 mẹ bia Tiger đầu tiên ra đời trong\n'
              '2 mẹ bia Tiger đầu tiên ra đời trong niềm hân hoa...',
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Text(
              translation(context).see_more,
              textAlign: TextAlign.left,
              style: const TextStyle(color: AppStyles.primaryColor),
            ),
            const ListProduct()
          ],
        ),
      ),
    );
  }
}
