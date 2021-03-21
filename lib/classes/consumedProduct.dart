import 'package:flutter/foundation.dart';

class ConsumedProduct {
  int quantity;
  final int barcode;
  final String name;

  ConsumedProduct({
    @required this.quantity,
    @required this.barcode,
    @required this.name,
  });

  factory ConsumedProduct.list(Map<String, dynamic> list) {
    return ConsumedProduct(
      quantity: list['quantity'] as int,
      barcode: list['barcode'] as int,
      name: list['name'] as String,
    );
  }
}
