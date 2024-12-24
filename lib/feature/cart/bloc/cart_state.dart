import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/cart/model/cart_dto.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final CartDTO cart;
  final List<OrderHistoryDTO> orderHistoryDTOs;

  const CartLoaded({required this.cart, required this.orderHistoryDTOs});

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object?> get props => [error];
}
