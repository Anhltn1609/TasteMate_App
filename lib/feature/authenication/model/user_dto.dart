import 'dart:io';

class UserDTO {
  final String id;
  final String email;
  final String fullname;
  final String phoneNumber;
  final bool isLocked;
  final String? avatar;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  UserDTO({
    required this.id,
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.isLocked,
    required this.avatar,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  UserDTO.defaultConstructor()
      : id = '',
        email = '',
        fullname = '',
        phoneNumber = '',
        isLocked = false,
        avatar = null,
        role = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        version = 0;

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isLocked: json['isLocked'] ?? false,
      avatar: json['avatar'],
      role: json['role'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'isLocked': isLocked,
      'avatar': avatar ?? '',
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  @override
  String toString() {
    return 'UserDTO{id: $id, email: $email, fullname: $fullname, phoneNumber: $phoneNumber, '
        'isLocked: $isLocked, avatar: $avatar, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, version: $version}';
  }
}
