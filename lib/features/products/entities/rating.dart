import 'package:ecommerce_app/core/utils/map_keys.dart';

class Rating {
  final double rate;
  final int count;

  Rating({required this.count, required this.rate});

  factory Rating.fromjson(Map<String, dynamic> json) {
    return Rating(
      rate: (json[MapKeys.rate] as num).toDouble(),
      count: json[MapKeys.count] as int,
    );
  }

  Map<String, dynamic> toJson() => {MapKeys.rate: rate, MapKeys.count: count};

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';
}
