import 'dart:convert';

class OrderDTO {
  final String recipientName;
  final String phoneNumber;
  final String detailAddress;
  final String note;
  final List<String> cartDetails;

  OrderDTO({
    required this.recipientName,
    required this.phoneNumber,
    required this.detailAddress,
    required this.note,
    required this.cartDetails,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      recipientName: json['recipientName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      detailAddress: json['detailAddress'] as String,
      note: json['note'] as String,
      cartDetails: List<String>.from(json['cartDetails'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientName': recipientName,
      'phoneNumber': phoneNumber,
      'detailAddress': detailAddress,
      'note': note,
      'cartDetails': cartDetails,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  static List<OrderDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => OrderDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
