import 'package:ecommerce_app/models/entity/rating.dart';
import 'package:ecommerce_app/models/entity/rating_converter.dart';
import 'package:ecommerce_app/utils/map_keys.dart';
import 'package:floor/floor.dart';

@TypeConverters([RatingConverter])
@entity
class Product {
  @primaryKey
  final int id;

  final int quantity;

  final String name;
  final double price;
  final String image;
  final String category;
  final String description;

  final Rating rating;

  Product({
    required this.id,
    this.quantity = 1,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[MapKeys.id],
      name: json[MapKeys.name],
      price: (json[MapKeys.price] as num).toDouble(),
      category: json[MapKeys.category],
      description: json[MapKeys.description],
      image: json[MapKeys.image],
      rating: Rating.fromjson(json[MapKeys.rating]),
    );
  }

  // @override
  // String toString() {
  //   return 'Product(id: $id, name: $name, price: $price, rating: $rating)';
  // }
  
}
