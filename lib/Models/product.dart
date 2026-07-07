// lib/Models/product.dart
class Product {
  final String id;
  final String? categoryId;
  final String? subcategoryId;
  final String name;
  final String? description;
  final String price; // keep as String because your API returns price as string
  final String? stock;
  final String? createdAt;
  final String img;

  Product({
    required this.id,
    this.categoryId,
    this.subcategoryId,
    required this.name,
    this.description,
    required this.price,
    this.stock,
    this.createdAt,
    required this.img,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] ?? "").toString(),
      categoryId: json['category_id']?.toString(),
      subcategoryId: json['subcategory_id']?.toString(),
      name: (json['name'] ?? "").toString(),
      description: json['description']?.toString(),
      price: (json['price'] ?? "").toString(),
      stock: json['stock']?.toString(),
      createdAt: json['created_at']?.toString(),
      // Some APIs provide full url already, otherwise the PHP script we provided does it
      img: (json['img'] ?? "").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'subcategory_id': subcategoryId,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'created_at': createdAt,
        'img': img,
      };
}
