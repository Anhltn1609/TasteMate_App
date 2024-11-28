import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/feature/cart/model/product.dart';

class ProductTab extends StatelessWidget {
  final List<Product> products = [
    Product(
      image: "fakeUrl",
      name: 'Rau củ & Trái cây',
      price: 50000,
      quantity: 10,
      description: 'Fresh fruits and vegetables',
    ),
    Product(
      image: "fakeUrl",
      name: 'Trứng, Sữa & Đậu phụ',
      price: 60000,
      quantity: 20,
      description: 'Eggs, milk, and tofu products',
    ),
    Product(
      image: "fakeUrl",
      name: 'Góc ăn sáng',
      price: 40000,
      quantity: 15,
      description: 'Breakfast corner items',
    ),
    Product(
      image: "fakeUrl",
      name: 'Góc bếp',
      price: 70000,
      quantity: 5,
      description: 'Kitchen essentials',
    ),
    Product(
      image: "fakeUrl",
      name: 'Thực phẩm tươi',
      price: 80000,
      quantity: 25,
      description: 'Fresh groceries',
    ),
    Product(
      image: "fakeUrl",
      name: 'Bánh mì & Bánh ngọt',
      price: 30000,
      quantity: 30,
      description: 'Bread and pastries',
    ),
    Product(
      image: "fakeUrl",
      name: 'Thực phẩm tươi',
      price: 80000,
      quantity: 25,
      description: 'Fresh groceries',
    ),
    Product(
      image: AppConfigs.fakeUrl,
      name: 'Bánh mì & Bánh ngọt',
      price: 30000,
      quantity: 30,
      description: 'Bread and pastries',
    ),
  ];

  ProductTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.categoryDetail,
                  arguments: index);
            },
            child: ProductItemWidget(
              title: products[index].name,
              image: products[index].image,
            ),
          );
        },
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final String title;
  final String image;

  ProductItemWidget({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
            image: NetworkImage(AppConfigs.fakeUrl), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
