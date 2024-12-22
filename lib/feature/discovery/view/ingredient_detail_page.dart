import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_configs.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';

class IngredientDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết sản phẩm",
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and Price
              Center(
                child: Column(
                  children: [
                    Image.network(
                      AppConfigs.fakeUrl,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "45,000 đ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Product Title
              Text(
                "Trứng Gà Sạch Tamagoya - Rice Color",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Product Details
              Row(
                children: [
                  Icon(Icons.flag, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Xuất xứ: Việt Nam"),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.store, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Thương hiệu: Rice Color"),
                ],
              ),
              SizedBox(height: 16),

              // Wishlist Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Thêm vào giỏ hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Related Products
              Text(
                "Mọi người cũng đã mua",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildRelatedProduct("https://via.placeholder.com/100",
                        "Nước Soda", "57,000 đ"),
                    _buildRelatedProduct("https://via.placeholder.com/100",
                        "Pate Gà", "90,000 đ"),
                    _buildRelatedProduct("https://via.placeholder.com/100",
                        "Cao Fuji", "209,000 đ"),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Product Information
              Text(
                "Thông tin sản phẩm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "- Giàu đường chất và axit amin\n"
                "- Giúp giảm rủi ro cholesterol HDL\n"
                "- Giúp giảm nguy cơ mắc các bệnh về tim và đột quỵ",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Xem thêm",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedProduct(String imageUrl, String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.network(AppConfigs.fakeUrl, height: 70, fit: BoxFit.cover),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Thêm vào giỏ",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
          ),
        ],
      ),
    );
  }
}
