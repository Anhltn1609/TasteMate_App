import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';
import 'package:tastemate_app/feature/order/model/order_dto.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class LoadOrderEvent extends OrderEvent {
  final List<CartDetailsDTO> selectedCartDetails;

  const LoadOrderEvent(this.selectedCartDetails);

  @override
  List<Object?> get props => [selectedCartDetails];
}

class CreateOrderEvent extends OrderEvent {
  final OrderDTO order;

  const CreateOrderEvent({required this.order});

  @override
  List<Object?> get props => [order];
}
