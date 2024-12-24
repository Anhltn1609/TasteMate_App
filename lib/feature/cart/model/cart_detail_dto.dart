import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';

class CartDetailsDTO {
  final IngredientDTO ingredient;
  final int quantity;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int subtotal;

  CartDetailsDTO({
    required this.ingredient,
    required this.quantity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.subtotal,
  });

  factory CartDetailsDTO.fromJson(Map<String, dynamic> json) {
    return CartDetailsDTO(
      ingredient:
          IngredientDTO.fromJson(json['ingredient'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      subtotal: json['subtotal'] as int,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient.toJson(),
      'quantity': quantity,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'subtotal': subtotal,
    };
  }

  // Static method to create a list of CartDetailsDTO from a list of JSON objects
  static List<CartDetailsDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CartDetailsDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
