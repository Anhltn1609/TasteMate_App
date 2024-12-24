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
    final int n;
    if (json['nutritionalValue'] is double) {
      n = (json['nutritionalValue'] as double).round();
    } else {
      n = int.tryParse(json['nutritionalValue'].toString()) ?? 0;
    }
    return QuantityDTO(
      id: json['_id'],
      ingredient: IngredientDTO.fromJson(json['ingredientInfo']),
      quantity: n,
    );
  }

  static List<QuantityDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => QuantityDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
