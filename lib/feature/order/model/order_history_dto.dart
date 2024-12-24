import 'package:tastemate_app/feature/order/model/orderDetail.dart';

class OrderHistoryDTO {
  final String id;
  final String user;
  final List<OrderDetailDTO> orderDetails;
  final int totalPrice;
  final String status;
  final String recipientName;
  final String phoneNumber;
  final String detailAddress;
  final String note;

  OrderHistoryDTO({
    required this.id,
    required this.user,
    required this.orderDetails,
    required this.totalPrice,
    required this.status,
    required this.recipientName,
    required this.phoneNumber,
    required this.detailAddress,
    required this.note,
  });

  factory OrderHistoryDTO.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDTO(
      id: json['_id'] as String,
      user: json['user'] as String,
      orderDetails: OrderDetailDTO.listFromJson(json['orderDetails']),
      totalPrice: json['totalPrice'] as int,
      status: json['status'] as String,
      recipientName: json['recipientName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      detailAddress: json['detailAddress'] as String,
      note: json['note'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'orderDetails': orderDetails.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'recipientName': recipientName,
      'phoneNumber': phoneNumber,
      'detailAddress': detailAddress,
      'note': note,
    };
  }

  static List<OrderHistoryDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderHistoryDTO.fromJson(json)).toList();
  }
}
