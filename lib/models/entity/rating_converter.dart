import 'dart:convert';
import 'package:ecommerce_app/models/entity/rating.dart';
import 'package:ecommerce_app/utils/map_keys.dart';
import 'package:floor/floor.dart';

class RatingConverter extends TypeConverter<Rating,String> {

  @override
  Rating decode (String encodedRating) {
    final Map<String,dynamic> json = jsonDecode(encodedRating);
     return Rating(
      rate: json[MapKeys.rate].toDouble() ,
      count: json[MapKeys.count]  
    );
  }

  @override
  String encode(Rating rating) {
    return jsonEncode(rating.toJson());
  }
}
 
  
