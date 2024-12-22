class UserCreateDTO {
  final String email;
  final String fullname;
  final String phoneNumber;
  final String password;

  UserCreateDTO({
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.password,
  });

  factory UserCreateDTO.fromJson(Map<String, dynamic> json) {
    return UserCreateDTO(
      email: json['email'],
      fullname: json['fullname'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserCreateDTO{email: $email, fullname: $fullname, phoneNumber: $phoneNumber, password: $password}';
  }
}
