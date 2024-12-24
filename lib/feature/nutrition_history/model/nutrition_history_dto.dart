class NutritionHistoryDTO {
  final String id;
  final String userId;
  final DateTime recordedAt;
  final List<String> consumedItems;
  final String? journey;
  final double totalNutrition;
  final DateTime createdAt;
  final DateTime updatedAt;

  NutritionHistoryDTO({
    required this.id,
    required this.userId,
    required this.recordedAt,
    required this.consumedItems,
    this.journey,
    required this.totalNutrition,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NutritionHistoryDTO.fromJson(Map<String, dynamic> json) {
    return NutritionHistoryDTO(
      id: json['_id'] as String,
      userId: json['user'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      consumedItems: List<String>.from(json['consumedItems'] ?? []),
      journey: json['journey'] as String?,
      totalNutrition: (json['totalNutrition'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'recordedAt': recordedAt.toIso8601String(),
      'consumedItems': consumedItems,
      'journey': journey,
      'totalNutrition': totalNutrition,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static List<NutritionHistoryDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => NutritionHistoryDTO.fromJson(json)).toList();
  }
}
