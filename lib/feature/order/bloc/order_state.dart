import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<CartDetailsDTO> cartDetails;
  final double totalPrice;

  const OrderLoaded({required this.cartDetails, required this.totalPrice});

  @override
  List<Object?> get props => [cartDetails, totalPrice];
}

class OrderError extends OrderState {
  final String error;

  const OrderError(this.error);

  @override
  List<Object?> get props => [error];
}

class OrderSuccess extends OrderState {}
