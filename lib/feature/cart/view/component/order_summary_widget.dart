import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thành tiền', style: TextStyle(fontSize: 16)),
              Text('171,000đ', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phí giao hàng', style: TextStyle(fontSize: 16)),
              Text('30,000đ', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Promo code functionality here
            },
            child: Row(
              children: [
                Text('NHẬP MÃ KHUYẾN MẠI',
                    style: TextStyle(color: Colors.green)),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.green, size: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Mô tả về địa chỉ nhận hàng hay các lưu ý cho đơn hàng',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
