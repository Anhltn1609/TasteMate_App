import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tastemate_app/core/services/errors/api_exceptions.dart';

class CommonAlertView extends StatelessWidget {
  const CommonAlertView({super.key, required this.exception, this.onRetry});
  final dynamic exception;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    var errMsg = 'Something went wrong, please try again later!';

    if (exception is ApiException) {
      errMsg = (exception as ApiException).error.message ?? errMsg;
    } else {
      if (kDebugMode) {
        errMsg = exception.toString();
      }
      log(exception.toString());
    }

    return AlertDialog.adaptive(
      content: Center(
        child: Text(errMsg),
      ),
      actions: [
        if (onRetry != null)
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          )
      ],
    );
  }
}
