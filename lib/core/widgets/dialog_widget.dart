import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String message;

  const CustomDialogWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Thông báo",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog
          },
          child: const Text(
            "Đóng",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  static Future<void> _showSimpleDialog(BuildContext context) async =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogWidget(
            message: "Đây là thông báo của bạn!",
          );
        },
      );
}
