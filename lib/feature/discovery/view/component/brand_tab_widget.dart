import 'package:flutter/material.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/discovery/model/Brand.dart';

class BrandTab extends StatelessWidget {
  final List<Brand> brands = [
    Brand(
        name: 'Mr. Viet',
        description: 'Cà phê',
        logo: 'https://fakeurl.com/mrviet.png'),
    Brand(
        name: 'Acqua Panna',
        description: 'Nước khoáng thiên nhiên',
        logo: 'https://fakeurl.com/acquapanna.png'),
    Brand(
        name: 'Delverde',
        description: 'Mì Ý',
        logo: 'https://fakeurl.com/delverde.png'),
    Brand(
        name: 'Madama Oliva',
        description: 'Oliu',
        logo: 'https://fakeurl.com/madamaoliva.png'),
    Brand(
        name: 'Le Fruit',
        description: 'Nước ép trái cây',
        logo: 'https://fakeurl.com/lefruit.png'),
    Brand(
        name: 'Ba Huân',
        description: 'Trứng & Thịt gia cầm',
        logo: 'https://fakeurl.com/bahuan.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.brandDetail, arguments: index);
          },
          child: BrandItemWidget(
            name: brand.name,
            description: brand.description,
            logo: AppConfigs.fakeUrl,
          ),
        );
      },
    );
  }
}

class BrandItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final String logo;

  BrandItemWidget({
    required this.name,
    required this.description,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(logo),
        radius: 24,
      ),
      title: Text(name, style: const TextStyle(fontSize: 18)),
      subtitle: Text(description),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
