import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/cart/model/product.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Product> products;
  final String title;
  const CategoryListWidget({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppStyles.textBold,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 300,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(AppConfigs.fakeUrl, height: 100, fit: BoxFit.cover),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.green,
                  child: const Text(
                    'Mới',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '300g',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            '${product.price} đ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            product.name,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'Vietnam',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // Handle add to cart
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              "+ Thêm vào giỏ",
              style: TextStyle(color: AppStyles.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
