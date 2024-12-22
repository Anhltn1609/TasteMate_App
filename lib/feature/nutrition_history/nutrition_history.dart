import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/dashboard/view/nutrition_summary_widget.dart';

class NutritionHistoryPage extends StatelessWidget {
  // Dữ liệu giả lập cho NutritionHistory
  final List<Map<String, dynamic>> nutritionHistory = [
    {
      "nutrition_history_id": "1",
      "recorded_at": "2024-12-20",
      "consumed_items": [
        {"name": "Cơm gà", "calories": 500},
        {"name": "Nước ép cam", "calories": 150},
        {"name": "Snack", "calories": 250},
      ],
      "total_nutrition": 900,
    },
    {
      "nutrition_history_id": "2",
      "recorded_at": "2024-12-19",
      "consumed_items": [
        {"name": "Phở bò", "calories": 450},
        {"name": "Cà phê sữa", "calories": 120},
        {"name": "Bánh mì", "calories": 200},
      ],
      "total_nutrition": 770,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/images_6.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nutrition Summary Widget
                    Card(
                      color: Colors.white,
                      child: NutritionSummaryWidget(),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lịch sử chi tiết:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Hiển thị danh sách Nutrition History
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(), // Tắt cuộn
                      shrinkWrap: true, // Mở rộng theo nội dung
                      itemCount: nutritionHistory.length,
                      itemBuilder: (context, index) {
                        final item = nutritionHistory[index];
                        final consumedItems = item["consumed_items"];

                        return Card(
                          color:
                              Colors.white.withOpacity(0.9), // Làm thẻ trong mờ
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date of record
                                Text(
                                  "Ngày: ${item['recorded_at']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 8),

                                // Total Calories
                                Text(
                                  "Tổng calories: ${item['total_nutrition']} kcal",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                ),
                                SizedBox(height: 8),

                                // Consumed Items List
                                Text(
                                  "Các món đã tiêu thụ:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 8),
                                ...consumedItems.map<Widget>((food) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "- ${food['name']}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "${food['calories']} kcal",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
