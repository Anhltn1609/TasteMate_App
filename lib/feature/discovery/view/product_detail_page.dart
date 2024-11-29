import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/constants/language_constants.dart';
import 'package:tastemate_app/feature/cart/model/product.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final List<Product> products = [
    Product(
      image: 'https://example.com/images/egg.jpg',
      name: 'Trứng Gà Sạch Tamagoya',
      price: 45000,
      quantity: 1,
      description:
          'Trứng gà giàu dinh dưỡng và chất lượng cao, sản phẩm sạch từ trang trại Tamagoya.',
    ),
    Product(
      image: 'https://example.com/images/yakult.jpg',
      name: 'Sữa Chua Yakult',
      price: 29000,
      quantity: 1,
      description:
          'Sữa chua Yakult tốt cho tiêu hóa và sức khỏe, bổ sung lợi khuẩn.',
    ),
    Product(
      image: 'https://example.com/images/soy_milk.jpg',
      name: 'Sữa Đậu Nành',
      price: 45000,
      quantity: 1,
      description:
          'Sữa đậu nành nguyên chất giàu dinh dưỡng, thơm ngon, và bổ dưỡng.',
    ),
    Product(
      image: 'https://example.com/images/ramen.jpg',
      name: 'Mì Sợi Ramen',
      price: 20000,
      quantity: 1,
      description:
          'Mì ramen Nhật Bản, sợi mì dai ngon, phù hợp với các món ăn phong cách Nhật.',
    ),
    Product(
      image: 'https://example.com/images/gyoza_wrapper.jpg',
      name: 'Vỏ Bánh Gyoza',
      price: 25000,
      quantity: 1,
      description:
          'Vỏ bánh gyoza dai và mềm, lý tưởng cho các món bánh Nhật như gyoza.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).product_detail,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.network(
                  AppConfigs.fakeUrl,
                  width: 300,
                  height: 150,
                ),
              ),
              const SizedBox(height: 16),
              // Product Info
              Text(
                'Trứng Gà Sạch Tamagoya - Rice Color',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Xuất xứ: Việt Nam',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Thương hiệu: Rice Color',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                '45,000 đ',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Thêm vào Wishlist',
                    style: TextStyle(color: Colors.green)),
              ),
              SizedBox(height: 24),

              // Related Products Section
              Text(
                'Mọi người cũng đã mua',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RecommendedProductsList(products: products),
              SizedBox(height: 24),

              // Product Information
              Text(
                'Thông tin sản phẩm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- Giàu dưỡng chất và axit amin'),
              Text('- Giúp sản sinh ra cholesterol HDL'),
              Text('- Giúp giảm nguy cơ mắc các bệnh về tim và đột...'),
              SizedBox(height: 24),

              // Related Brands Section
              Text(
                'Cùng thương hiệu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SameBrandProductList(products: products),
              SizedBox(height: 24),

              // Checkout Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove, color: Colors.green),
                      ),
                      Text('1', style: TextStyle(fontSize: 18)),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.green),
                      ),
                    ],
                  ),
                  const Text(
                    'Tổng cộng: 45,000 đ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SameBrandProductList extends StatelessWidget {
  final List<Product> products;

  const SameBrandProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItemWidget(
              name: product.name, price: product.price, image: product.image);
        },
      ),
    );
  }
}

class RecommendedProductsList extends StatelessWidget {
  final List<Product> products;

  const RecommendedProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItemWidget(
              name: product.name, price: product.price, image: product.image);
        },
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final String name;
  final int price;
  final String image;

  const ProductItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.grey.shade200,
          child: Image.network(AppConfigs.fakeUrl, fit: BoxFit.cover),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 14)),
        Text(
          '$price đ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
