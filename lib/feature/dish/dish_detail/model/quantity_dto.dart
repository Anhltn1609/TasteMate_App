import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';

class QuantityDTO {
  final String id;
  final IngredientDTO ingredient;
  final int quantity;

  QuantityDTO({
    required this.id,
    required this.ingredient,
    required this.quantity,
  });

  // Factory method to create an instance from JSON
  factory QuantityDTO.fromJson(Map<String, dynamic> json) {
    return QuantityDTO(
      id: json['_id'],
      ingredient: IngredientDTO.fromJson(json['ingredientInfo']),
      quantity: json['quantity'],
    );
  }

  static List<QuantityDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => QuantityDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
