import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/cart/model/cart_dto.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCartEvent extends CartEvent {
  final CartDTO cart;

  const UpdateCartEvent(this.cart);

  @override
  List<Object?> get props => [cart];
}

class ClearCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddIngredientToCartEvent extends CartEvent {
  final String ingredientId;

  const AddIngredientToCartEvent(this.ingredientId);

  @override
  List<Object?> get props => [ingredientId];
}

class AddIngredientsToCartEvent extends CartEvent {
  final String ingredientId;
  final int quantity;

  const AddIngredientsToCartEvent(this.ingredientId, this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class RemoveIngredientFromCartEvent extends CartEvent {
  final String ingredientId;

  const RemoveIngredientFromCartEvent(this.ingredientId);

  @override
  List<Object?> get props => [ingredientId];
}

class RemoveIngredientsFromCartEvent extends CartEvent {
  final String ingredientId;
  final int quantity;

  const RemoveIngredientsFromCartEvent(this.ingredientId, this.quantity);

  @override
  List<Object?> get props => [ingredientId, quantity];
}
