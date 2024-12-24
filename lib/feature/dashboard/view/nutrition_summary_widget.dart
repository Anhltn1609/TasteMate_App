import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_bloc.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_state.dart';

class NutritionSummaryWidget extends StatelessWidget {
  const NutritionSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionHistoryBloc, NutritionHistoryState>(
      builder: (context, state) {
        if (state is NutritionHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NutritionHistoryLoaded) {
          final todayNutrition = state.nutritionHistory.isNotEmpty
              ? state.nutritionHistory.first
              : null;

          if (todayNutrition == null) {
            return const Center(
              child: Text(
                'Không có dữ liệu dinh dưỡng hôm nay.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade300,
                            Colors.green.shade700
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${todayNutrition.totalNutrition}', // Tổng calo
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              Text(
                                'calo đã tiêu thụ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.grey),
                    ),
                    Text(
                      'Hôm nay, ${todayNutrition.recordedAt.toLocal().toString().split(' ')[0]}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
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
          child: Text('Dữ liệu dinh dưỡng chưa sẵn sàng.'),
        );
      },
    );
  }
}
