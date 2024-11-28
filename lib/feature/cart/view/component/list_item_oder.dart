import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';

class ListItemOrder extends StatelessWidget {
  final List<Product> items = [
    Product(
      image: 'https://fakeurl.com/image1.jpg',
      name: 'Sữa Chua Uống Lên Men Ít Đường',
      price: 31000,
      quantity: 1,
      description: '5 chai x 65ml',
    ),
    Product(
      image: 'https://fakeurl.com/image2.jpg',
      name: 'Trứng Gà Sạch Tamagoya - Rice Color',
      price: 45000,
      quantity: 1,
      description: 'Hộp 10 trứng',
    ),
    Product(
      image: 'https://fakeurl.com/image3.jpg',
      name: 'Táo Breeze - Tony Fruits',
      price: 95000,
      quantity: 1,
      description: '800-900g',
    ),

    // Add more items here if needed
  ];

  ListItemOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((product) {
        return CartItem(
          image: AppConfigs.fakeUrl,
          name: product.name,
          price: product.price,
          quantity: product.quantity,
          description: product.description,
        );
      }).toList(),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final int quantity;
  final String description;

  const CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.network(
            image,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  '${price}đ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.green),
                onPressed: () {
                  // Todo: Chức năng giảm số lượng
                },
              ),
              Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  // Todo: Chức năng tăng số lượng
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Product {
  final String image;
  final String name;
  final int price;
  final int quantity;
  final String description;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
  });
}
