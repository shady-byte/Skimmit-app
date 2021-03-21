import 'package:flutter/foundation.dart';

class Product {
  final Map<String, dynamic> meta;
  final String category;
  final String id;
  final String name;
  final int barcode;
  final String imageurl;
  final List<dynamic> diseases;

  Product({
    @required this.meta,
    @required this.category,
    @required this.id,
    @required this.name,
    @required this.barcode,
    @required this.imageurl,
    @required this.diseases,
  });

  factory Product.list(Map<String, dynamic> list) {
    return Product(
      meta: list['meta'] as Map<String, dynamic>,
      category: list['category'] as String,
      id: list['id'] as String,
      name: list['name'] as String,
      barcode: list['barcode'] as int,
      imageurl: list['image_url'] as String,
      diseases: list['diseases'] as List<dynamic>,
    );
  }
}
