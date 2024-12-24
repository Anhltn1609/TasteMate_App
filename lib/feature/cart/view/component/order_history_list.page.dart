import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/order/model/order_history_dto.dart';

class OrderHistoryListWidget extends StatefulWidget {
  final List<OrderHistoryDTO> orders;

  const OrderHistoryListWidget({super.key, required this.orders});

  @override
  State<OrderHistoryListWidget> createState() => _OrderHistoryListWidgetState();
}

class _OrderHistoryListWidgetState extends State<OrderHistoryListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "Danh sách các đơn hàng đã đặt",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppStyles.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 600,
            width: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.orders.length,
              itemBuilder: (context, index) {
                final order = widget.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${order.id}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Recipient: ${order.recipientName}'),
                        const SizedBox(height: 8),
                        Text('Phone: ${order.phoneNumber}'),
                        const SizedBox(height: 8),
                        Text('Address: ${order.detailAddress}'),
                        const SizedBox(height: 8),
                        Text('Status: ${order.status}'),
                        const SizedBox(height: 8),
                        Text('Total Price: ${order.totalPrice} đ'),
                        const SizedBox(height: 8),
                        Text(
                          'Note: ${order.note.isNotEmpty ? order.note : "No notes"}',
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Order Details:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: (20 + order.orderDetails.length * 100)
                              .roundToDouble(),
                          width: 350,
                          child: ListView.builder(
                            itemCount: order.orderDetails.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, detailIndex) {
                              final detail = order.orderDetails[detailIndex];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    detail.ingredient.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  detail.ingredient.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                subtitle: Text(
                                    'Tên nguyên liệu: ${detail.ingredient.name} '
                                    '\nSố lượng :${detail.quantity} ${detail.ingredient.unit} '
                                    '\nThành tiền: ${detail.totalPrice} đ'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
