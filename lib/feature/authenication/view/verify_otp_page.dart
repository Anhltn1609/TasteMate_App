import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/widgets/dialog_widget.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_bloc.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_event.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_state.dart';
import 'package:tastemate_app/feature/authenication/model/verify_otp_dto.dart';

class VerifyOtpPage extends StatefulWidget {
  final String email;

  const VerifyOtpPage({super.key, required this.email});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  void _verifyOtp() {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialogWidget(
            message: 'Vui lòng nhập mã OTP',
          );
        },
      );
      return;
    }

    context.read<AuthBloc>().add(VerifyOtpEvent(
        verifyOtpDTO: VerifyOtpDTO(email: widget.email, otp: otp)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác minh OTP'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is OtpVerified) {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.resetPassword,
                arguments: widget.email);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogWidget(
                  message: 'Xác minh thành công',
                );
              },
            );
          } else if (state is AuthFailure) {
            Navigator.of(context).pop();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogWidget(
                  message: state.message,
                );
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nhập mã OTP đã được gửi đến email của bạn',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Mã OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Xác minh',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
