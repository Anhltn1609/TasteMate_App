class VerifyOtpDTO {
  final String email;
  final String otp;

  VerifyOtpDTO({
    required this.email,
    required this.otp,
  });

  factory VerifyOtpDTO.fromJson(Map<String, dynamic> json) {
    return VerifyOtpDTO(
      email: json['email'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  @override
  String toString() {
    return 'VerifyOtpDTO{email: $email, otp: $otp}';
  }
}
