import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/dish/dish_detail/model/quantity_dto.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';

class DishWithIngredientsDTO {
  final DishDTO dish;
  final List<QuantityDTO> quantityDTO;

  DishWithIngredientsDTO({
    required this.dish,
    required this.quantityDTO,
  });

  // Factory method to create an instance from JSON
  factory DishWithIngredientsDTO.fromJson(Map<String, dynamic> json) {
    return DishWithIngredientsDTO(
      dish: DishDTO.fromJson(json['dishes']),
      quantityDTO: QuantityDTO.listFromJson(json['ingredients']),
    );
  }
}
