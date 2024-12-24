import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/order/bloc/order_event.dart';
import 'package:tastemate_app/feature/order/bloc/order_state.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final ApiService _apiService;

  OrderBloc(this._apiService) : super(OrderInitial()) {
    on<LoadOrderEvent>(_onLoadOrder);
    on<CreateOrderEvent>(_onCreateOrder);
  }

  Future<void> _onLoadOrder(
      LoadOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      emit(OrderLoaded(cartDetails: event.selectedCartDetails, totalPrice: 1));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final isSuccess = await _apiService.createOrder(event.order);
      if (isSuccess) {
        emit(OrderSuccess());
      } else {
        emit(OrderError("Không thể tạo đơn hàng"));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
