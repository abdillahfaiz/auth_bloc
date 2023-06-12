import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "title": "New Product",
//   "price": 10,
//   "description": "A description",
//   "categoryId": 1,
//   "images": ["https://placeimg.com/640/480/any"]
// }

class ProductModel {
  final String title;
  final int price;
  final String description;
  final int categoryId;
  final List<String> images;
  ProductModel({
    required this.title,
    required this.price,
    required this.description,
    this.categoryId = 1,
    this.images = const ['https://placeimg.com/640/480/any'],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'description': description,
      'categoryId': categoryId,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      categoryId: map['categoryId'] as int,
      images: List<String>.from(
        (map['images'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
