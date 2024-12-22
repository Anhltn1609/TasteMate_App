class CategoryDTO {
  final String id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  CategoryDTO({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory method to create an instance from JSON
  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  // Static method to create a list of CategoryDTO from a list of JSON objects
  static List<CategoryDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CategoryDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
