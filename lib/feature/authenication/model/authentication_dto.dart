class AuthenticationDTO {
  final String email;
  final String password;
  AuthenticationDTO({
    required this.email,
    required this.password,
  });
  factory AuthenticationDTO.fromJson(Map<String, dynamic> json) {
    return AuthenticationDTO(
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'AuthenticationDTO{email: $email, password : $password}';
  }
}
