import 'package:tastemate_app/core/constants/app_configs.dart';

class IngredientDTO {
  final String id;
  final String name;
  final int nutritionalValue;
  final String description;
  final String image;
  final String unit;
  final int price;
  final int stockQuantity;
  final String supplier;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  IngredientDTO({
    required this.id,
    required this.name,
    required this.nutritionalValue,
    required this.description,
    required this.image,
    required this.unit,
    required this.price,
    required this.stockQuantity,
    required this.supplier,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory method to create an instance from JSON
  factory IngredientDTO.fromJson(Map<String, dynamic> json) {
    return IngredientDTO(
      id: json['_id'] as String,
      name: json['name'] as String,
      nutritionalValue: json['nutritionalValue'] as int,
      description: (json['description'] as String?) ?? "",
      image: (json['image'] as String?) ?? AppConfigs.fakeUrl,
      unit: json['unit'] as String,
      price: json['price'] as int,
      stockQuantity: json['stockQuantity'] as int,
      supplier: json['supplier'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'nutritionalValue': nutritionalValue,
      'description': description,
      'image': image,
      'unit': unit,
      'price': price,
      'stockQuantity': stockQuantity,
      'supplier': supplier,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  static List<IngredientDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => IngredientDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
