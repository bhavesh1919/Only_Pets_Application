class Product {
  final String id;
  final String name;
  final String price;
  final String stock;
  final String imageUrl;
  final String categoryName;
  final String subcategoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.categoryName,
    required this.subcategoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      price: json['price'].toString(),
      stock: json['stock'].toString(),
      imageUrl: json['imageUrl'] ?? '',
      categoryName: json['category_name'] ?? '',
      subcategoryName: json['subcategory_name'] ?? '',
    );
  }
}
