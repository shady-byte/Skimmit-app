import 'package:flutter/foundation.dart';
import 'package:graduation_project/classes/consumedProduct.dart';

class WeekProducts {
  final int calories;
  final List<ConsumedProduct> products;

  WeekProducts({
    @required this.calories,
    @required this.products,
  });

  factory WeekProducts.list(Map<String, dynamic> list) {
    return WeekProducts(
      calories: list['daily_calories'] as int,
      products: list['products']
          .map<ConsumedProduct>((item) => ConsumedProduct.list(item))
          .toList() as List<ConsumedProduct>,
    );
  }
}
