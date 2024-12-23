class DishDTO {
  final String id;
  final String name;
  final String image;
  final String recipe;
  final int nutritionalValue;
  final String description;

  DishDTO({
    required this.id,
    required this.name,
    required this.image,
    required this.recipe,
    required this.nutritionalValue,
    required this.description,
  });

  factory DishDTO.fromJson(Map<String, dynamic> json) {
    final int n;
    if (json['nutritionalValue'] is double) {
      n = (json['nutritionalValue'] as double).round();
    } else {
      n = int.tryParse(json['nutritionalValue'].toString()) ?? 0;
    }

    return DishDTO(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      recipe: json['recipe'] as String,
      nutritionalValue: n ,
      description: json['description'] as String,
    );
  }

  static List<DishDTO> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => DishDTO.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'recipe': recipe,
      'nutritionalValue': nutritionalValue,
      'description': description,
    };
  }
}
