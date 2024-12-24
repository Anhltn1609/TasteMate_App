import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_bloc.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_event.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_state.dart';

class NutritionHistoryPage extends StatelessWidget {
  const NutritionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lịch Sử Dinh Dưỡng",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
      ),
      body: Stack(
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
          BlocBuilder<NutritionHistoryBloc, NutritionHistoryState>(
            builder: (context, state) {
              if (state is NutritionHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NutritionHistoryLoaded) {
                final nutritionHistory = state.nutritionHistory;

                if (nutritionHistory.isEmpty) {
                  return const Center(
                    child: Text(
                      "Không có lịch sử dinh dưỡng.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: nutritionHistory.length,
                  itemBuilder: (context, index) {
                    final item = nutritionHistory[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date of the record
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ngày: ${item.recordedAt.toLocal().toString().split(' ')[0]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Total Nutrition
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Tổng calories:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "${item.totalNutrition} kcal",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                              color: Colors.grey,
                            ),

                            // Journey type
                            if (item.journey != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Hành trình:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      item.journey!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueGrey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Consumed Items
                            const Text(
                              "Các món đã tiêu thụ:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...item.consumedItems.map<Widget>((foodId) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "- Món ăn ID: $foodId",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.fastfood,
                                      size: 20,
                                      color: Colors.orange.shade400,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is NutritionHistoryEmpty) {
                return const Center(
                  child: Text(
                    "Không có lịch sử dinh dưỡng.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else if (state is NutritionHistoryError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                );
              }

              return const Center(
                child: Text("Chào mừng đến với lịch sử dinh dưỡng!"),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger the LoadNutritionHistoryEvent
          context
              .read<NutritionHistoryBloc>()
              .add(LoadNutritionHistoryEvent("user_id_placeholder"));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
