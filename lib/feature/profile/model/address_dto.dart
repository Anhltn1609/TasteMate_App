class AddressDTO {
  final String id;
  final String userId;
  final String recipientName;
  final String phoneNumber;
  final String detailAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  AddressDTO({
    required this.id,
    required this.userId,
    required this.recipientName,
    required this.phoneNumber,
    required this.detailAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory constructor for JSON deserialization
  factory AddressDTO.fromJson(Map<String, dynamic> json) {
    return AddressDTO(
      id: json['_id'],
      userId: json['user'],
      recipientName: json['recipientName'],
      phoneNumber: json['phoneNumber'],
      detailAddress: json['detailAddress'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'] as int,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'recipientName': recipientName,
      'phoneNumber': phoneNumber,
      'detailAddress': detailAddress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  static List<AddressDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => AddressDTO.fromJson(json)).toList();
  }
}
