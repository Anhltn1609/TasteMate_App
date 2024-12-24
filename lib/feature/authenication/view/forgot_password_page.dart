import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/router/routers.dart';
import 'package:tastemate_app/core/widgets/dialog_widget.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_bloc.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_event.dart';
import 'package:tastemate_app/feature/authenication/bloc/auth_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void _sendOtp() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogWidget(
            message: 'Email không hợp lệ',
          );
        },
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogWidget(
            message: 'Email không hợp lệ',
          );
        },
      );
      return;
    }

    context.read<AuthBloc>().add(SendOtpEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
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
          } else if (state is AuthSuccessOtpSent) {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, Routes.verifyOtp,
                arguments: _emailController.text);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogWidget(
                  message:
                      'Mã OTP đã được gửi đến email của bạn, hãy kiểm tra email',
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
                'Nhập email để nhận mã OTP',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Gửi mã OTP',
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
