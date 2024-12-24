import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/core/widgets/dialog_widget.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_bloc.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_event.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_state.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/profile/model/address_dto.dart';
import 'package:tastemate_app/feature/profile/model/user_update_dto.dart';

class UserInforPage extends StatefulWidget {
  const UserInforPage({super.key});

  @override
  State<UserInforPage> createState() => _UserInforPageState();
}

class _UserInforPageState extends State<UserInforPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedAvatar;
  late AddressDTO address;
  @override
  void initState() {
    super.initState();
    final user = ApiService.user;
    _fullnameController.text = user.fullname;
    _phoneNumberController.text = user.phoneNumber;
    final profileBloc = context.read<UserInforBloc>();
    profileBloc.add(LoadUserInforEvent());
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialogWidget(
            message: 'Không có bức ảnh nào được chọn',
          );
        },
      );
    }
  }

  void _updateProfile() {
    final fullname = _fullnameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    if (fullname.isEmpty || phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialogWidget(
            message: 'Hãy điền toàn bộ các trường thông tin',
          );
        },
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
            address: address,
          ),
        );
  }

  Widget _buildAddressWidget(AddressDTO address) {
    final TextEditingController addressController =
        TextEditingController(text: address.detailAddress);
    final TextEditingController recipientController =
        TextEditingController(text: address.recipientName);
    final TextEditingController phoneController =
        TextEditingController(text: address.phoneNumber);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recipient Name',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: recipientController,
          decoration: InputDecoration(
            labelText: 'Recipient Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
          onChanged: (value) {
            setState(() {
              recipientController.text = value;
            });
          },
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Detail Address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixIcon: const Icon(Icons.location_on),
          ),
          onChanged: (value) {
            setState(() {
              addressController.text = value;
            });
          },
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Phone',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixIcon: const Icon(Icons.phone),
          ),
          onChanged: (value) {
            setState(() {
              phoneController.text = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Information',
          style: TextStyle(
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
            address = state.addressDTO;
          } else if (state is UserInforFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          } else if (state is UserInforUpdateSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogWidget(
                  message: 'Cập nhật hồ sơ cá nhân thành công',
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is UserInforLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserInforLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: _selectedAvatar != null
                                  ? FileImage(_selectedAvatar!)
                                  : NetworkImage(state.user.avatar!)
                                      as ImageProvider,
                            ),
                            const CircleAvatar(
                              backgroundColor: AppStyles.primaryColor,
                              radius: 18,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
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
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  _buildAddressWidget(address),
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
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data available.'));
        },
      ),
    );
  }
}
