class Product {
  final String image;
  final String name;
  final int price;
  final int quantity;
  final String description;
  final String weight;
  final String origin;
  final bool isNew;
  final String category;
  final int? discount;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    this.weight = '',
    this.origin = '',
    this.isNew = false,
    this.category = '',
    this.discount,
  });
}
