import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_bloc.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_event.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_state.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/profile/model/user_update_dto.dart';

class UserInforPage extends StatefulWidget {
  const UserInforPage({Key? key}) : super(key: key);

  @override
  State<UserInforPage> createState() => _UserInforPageState();
}

class _UserInforPageState extends State<UserInforPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedAvatar;

  @override
  void initState() {
    super.initState();
    final user = ApiService.user;
    _fullnameController.text = user.fullname;
    _phoneNumberController.text = user.phoneNumber;
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có ảnh nào được chọn')),
      );
    }
  }

  void _updateProfile() {
    final fullname = _fullnameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    if (fullname.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    context.read<UserInforBloc>().add(
          ChangeUserProfileEvent(
            userUpdateDTO: UserUpdateDTO(
              file: _selectedAvatar,
              fullname: fullname,
              phoneNumber: phoneNumber,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppStyles.primaryColor),
        ),
      ),
      body: BlocConsumer<UserInforBloc, UserInforState>(
        listener: (context, state) {
          if (state is UserInforLoaded) {
            _fullnameController.text = state.user.fullname;
            _phoneNumberController.text = state.user.phoneNumber;
            setState(() {
              _selectedAvatar = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cập nhật thành công!')),
            );
          } else if (state is UserInforFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserInforLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = ApiService.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _selectedAvatar != null
                                ? FileImage(_selectedAvatar!)
                                : NetworkImage(user.avatar!) as ImageProvider,
                          ),
                          const CircleAvatar(
                            backgroundColor: AppStyles.primaryColor,
                            radius: 18,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Cập nhật thông tin',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
