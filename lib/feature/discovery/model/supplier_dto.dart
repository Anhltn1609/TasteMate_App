class SupplierDTO {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  SupplierDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory SupplierDTO.fromJson(Map<String, dynamic> json) {
    return SupplierDTO(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  static List<SupplierDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => SupplierDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
