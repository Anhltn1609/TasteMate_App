import 'dart:io';
import 'package:dio/dio.dart';

class UserUpdateDTO {
  final File? file;
  final String fullname;
  final String phoneNumber;

  UserUpdateDTO({
    required this.file,
    required this.fullname,
    required this.phoneNumber,
  });

  factory UserUpdateDTO.fromJson(Map<String, dynamic> json) {
    return UserUpdateDTO(
      file: json['file'] != null ? File(json['file']) : null,
      fullname: json['fullname'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'fullname': fullname,
      'phoneNumber': phoneNumber,
    };

    if (file != null) {
      data['files'] = [
        MultipartFile.fromFileSync(
          file!.path,
          filename: file!.path.split('/').last,
        ),
      ];
    }

    return data;
  }

  @override
  String toString() {
    return 'UserUpdateDTO{file: ${file?.path ?? "null"}, fullname: $fullname, phoneNumber: $phoneNumber}';
  }
}
