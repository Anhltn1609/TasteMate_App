import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_event.dart';
import 'package:tastemate_app/feature/cart/bloc/cart_state.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiService _apiService;
  CartBloc(this._apiService) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddIngredientToCartEvent>(_onAddIngredientToCart);
    on<AddIngredientsToCartEvent>(_onAddIngredientsToCart);
    on<RemoveIngredientFromCartEvent>(_onRemoveIngredientFromCart);
    on<RemoveIngredientsFromCartEvent>(_onRemoveIngredientsFromCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final List<OrderHistoryDTO>? ordersHistory =
          await _apiService.getAllOrders();
      final cart = await _apiService.getCart();
      if (cart != null && ordersHistory != null) {
        emit(CartLoaded(cart: cart, orderHistoryDTOs: ordersHistory));
      } else {
        emit(CartError("Lỗi tải cart"));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  // Future<void> _onUpdateCart(
  //     UpdateCartEvent event, Emitter<CartState> emit) async {
  //   emit(CartLoading());
  //   try {
  //     // Update cart in API
  //     final cart = await ApiService().updateCart(event.updatedCart);
  //     if (cart != null) {
  //       emit(CartLoaded(cart));
  //     } else {
  //       emit(CartError("Lỗi tải cart"));
  //     }
  //   } catch (e) {
  //     emit(CartError(e.toString()));
  //   }
  // }

  Future<void> _onAddIngredientToCart(
      AddIngredientToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final rs = await _apiService.addIngredientToCart(event.ingredientId);
      final cart = await _apiService.getCart();
      final List<OrderHistoryDTO>? ordersHistory =
          await _apiService.getAllOrders();
      if (rs && cart != null && ordersHistory != null) {
        emit(CartLoaded(
          cart: cart,
          orderHistoryDTOs: ordersHistory,
        ));
      } else {
        emit(CartError("Lỗi tải cart"));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddIngredientsToCart(
      AddIngredientsToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final rs = await _apiService.addIngredientsToCart(
          event.ingredientId, event.quantity);
      final cart = await _apiService.getCart();
      final List<OrderHistoryDTO>? ordersHistory =
          await _apiService.getAllOrders();
      if (rs && cart != null && ordersHistory != null) {
        emit(CartLoaded(
          cart: cart,
          orderHistoryDTOs: ordersHistory,
        ));
      } else {
        emit(CartError("Lỗi tải cart"));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveIngredientFromCart(
      RemoveIngredientFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final rs = await _apiService.removeIngredientFromCart(event.ingredientId);
      final cart = await _apiService.getCart();
      final List<OrderHistoryDTO>? ordersHistory =
          await _apiService.getAllOrders();
      if (rs && cart != null && ordersHistory != null) {
        emit(CartLoaded(
          cart: cart,
          orderHistoryDTOs: ordersHistory,
        ));
      } else {
        emit(CartError("Lỗi tải cart"));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveIngredientsFromCart(
      RemoveIngredientsFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final rs = await _apiService.removeIngredientsFromCart(
          event.ingredientId, event.quantity);
      final cart = await _apiService.getCart();
      final List<OrderHistoryDTO>? ordersHistory =
          await _apiService.getAllOrders();
      if (rs && cart != null && ordersHistory != null) {
        emit(CartLoaded(
          cart: cart,
          orderHistoryDTOs: ordersHistory,
        ));
      } else {
        emit(CartError("Lỗi tải cart"));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
