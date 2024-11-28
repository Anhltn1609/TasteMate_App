import 'package:flutter/material.dart';
import 'package:tastemate_app/feature/cart/model/product.dart';
import 'package:tastemate_app/feature/discovery/view/component/category_list_widget.dart';

class CategoryDetailPage extends StatelessWidget {
  final int categoryId;

  const CategoryDetailPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Rau củ & Trái cây",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.headset_mic, color: Colors.black),
            onPressed: () {
              // Handle helpdesk navigation
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Category Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryButton(label: 'Rau quả'),
                  CategoryButton(label: 'Nấm'),
                  CategoryButton(label: 'Trái cây'),
                  CategoryButton(label: 'Rau gia vị'),
                  CategoryButton(label: '...'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Product Grid
            CategoryListWidget(title: 'Rau quả', products: products),
            CategoryListWidget(title: 'Nấm', products: products),
            CategoryListWidget(title: 'Trái cây', products: products),
            CategoryListWidget(title: 'Rau gia vị', products: products),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  CategoryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Sample data
List<Product> products = [
  Product(
    image: 'assets/lettuce.png',
    name: 'Xà Lách Romaine - Kamereo',
    price: 30000,
    quantity: 1,
    description: 'Fresh lettuce from Vietnam',
  ),
  Product(
    image: 'assets/spinach.png',
    name: 'Cải Bó Xôi - Kamereo',
    price: 30000,
    quantity: 1,
    description: 'Fresh spinach from Vietnam',
  ),
  Product(
    image: 'assets/bean.png',
    name: 'Đậu Cove Non - Kamereo',
    price: 20000,
    quantity: 1,
    description: 'Fresh green beans from Vietnam',
  ),
  Product(
    image: 'assets/mushroom1.png',
    name: 'Nấm Bào Ngư - Kamereo',
    price: 50000,
    quantity: 1,
    description: 'Oyster mushrooms from Vietnam',
  ),
  Product(
    image: 'assets/mushroom2.png',
    name: 'Nấm Kim Châm - Kamereo',
    price: 40000,
    quantity: 1,
    description: 'Enoki mushrooms from Vietnam',
  ),
  Product(
    image: 'assets/lettuce.png',
    name: 'Xà Lách Romaine - Kamereo',
    price: 30000,
    quantity: 1,
    description: 'Fresh lettuce from Vietnam',
  ),
  Product(
    image: 'assets/spinach.png',
    name: 'Cải Bó Xôi - Kamereo',
    price: 30000,
    quantity: 1,
    description: 'Fresh spinach from Vietnam',
  ),
  Product(
    image: 'assets/bean.png',
    name: 'Đậu Cove Non - Kamereo',
    price: 20000,
    quantity: 1,
    description: 'Fresh green beans from Vietnam',
  ),
  Product(
    image: 'assets/mushroom1.png',
    name: 'Nấm Bào Ngư - Kamereo',
    price: 50000,
    quantity: 1,
    description: 'Oyster mushrooms from Vietnam',
  ),
  Product(
    image: 'assets/mushroom2.png',
    name: 'Nấm Kim Châm - Kamereo',
    price: 40000,
    quantity: 1,
    description: 'Enoki mushrooms from Vietnam',
  ),
];
