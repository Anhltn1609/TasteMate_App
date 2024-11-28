import 'package:flutter/material.dart';
import 'package:tastemate_app/app.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';

final List<Map<String, String>> products = [
  {
    'imageUrl': 'https://fakeurl.com/tiger-pack1.png',
    'volume': '24 x 330 ml',
    'price': '522,000 ₫',
    'status': 'HẾT',
  },
  {
    'imageUrl': 'https://fakeurl.com/tiger-pack2.png',
    'volume': '330ml x 24 lon',
    'price': '522,000 ₫',
    'status': 'HẾT',
  },
  {
    'imageUrl': 'https://fakeurl.com/tiger-pack3.png',
    'volume': '24 x 500 ml',
    'price': '600,000 ₫',
    'status': 'HẾT',
  },
  {
    'imageUrl': 'https://fakeurl.com/tiger-pack4.png',
    'volume': '12 x 330 ml',
    'price': '300,000 ₫',
    'status': 'HẾT',
  },
  {
    'imageUrl': 'https://fakeurl.com/tiger-pack5.png',
    'volume': '12 x 500 ml',
    'price': '350,000 ₫',
    'status': 'CÒN HÀNG',
  },
];

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.5,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItem(
          imageUrl: AppConfigs.fakeUrl,
          volume: product['volume']!,
          price: product['price']!,
          status: product['status']!,
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String volume;
  final String price;
  final String status;

  ProductItem({
    required this.imageUrl,
    required this.volume,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Image.network(
                imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.grey[700],
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(volume, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(price,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text(
            'Bia - Tiger\nViệt Nam',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppStyles.primaryColor),
            ),
            child: const Text('THÔNG BÁO TÔI'),
          ),
        ],
      ),
    );
  }
}
