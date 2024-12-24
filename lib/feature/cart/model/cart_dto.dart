import 'package:tastemate_app/feature/cart/model/cart_detail_dto.dart';

class CartDTO {
  final String id;
  final String user;
  final List<CartDetailsDTO> cartDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalQuantity;
  final int totalPrice;
  final int version;

  CartDTO({
    required this.id,
    required this.user,
    required this.cartDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.totalQuantity,
    required this.totalPrice,
    required this.version,
  });

  // Factory method to create an instance from JSON
  factory CartDTO.fromJson(Map<String, dynamic> json) {
    return CartDTO(
      id: json['_id'] as String,
      user: json['user'] as String,
      cartDetails:
          CartDetailsDTO.listFromJson(json['cartDetails'] as List<dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      totalQuantity: json['totalQuantity'] as int,
      totalPrice: json['totalPrice'] as int,
      version: json['__v'] as int,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'cartDetails': cartDetails.map((detail) => detail.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      '__v': version,
    };
  }

  // Static method to create a list of CartDTO from a list of JSON objects
  static List<CartDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CartDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
