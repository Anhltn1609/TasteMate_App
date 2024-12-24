import 'dart:convert';

import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';

class OrderDetailDTO {
  final IngredientDTO ingredient;
  final int quantity;
  final int price;
  final int totalPrice;
  final bool isReviewed;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderDetailDTO({
    required this.ingredient,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.isReviewed,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailDTO(
      ingredient: IngredientDTO.fromJson(json['ingredient']),
      quantity: json['quantity'] as int,
      price: json['price'] as int,
      totalPrice: json['totalPrice'] as int,
      isReviewed: json['isReviewed'] as bool,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient.toJson(),
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'isReviewed': isReviewed,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static List<OrderDetailDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderDetailDTO.fromJson(json)).toList();
  }
}
