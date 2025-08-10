import 'dart:async';
import 'package:ecommerce_app/models/dao/product_dao.dart';
import 'package:ecommerce_app/models/entity/product.dart';
import 'package:ecommerce_app/models/entity/rating_converter.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';

@TypeConverters([RatingConverter])
@Database(version: 1 , entities: [Product])
abstract class ProductDatabase extends FloorDatabase {
  ProductDao get productDao;
}
