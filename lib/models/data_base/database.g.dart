// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ProductDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ProductDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ProductDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ProductDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorProductDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ProductDatabaseBuilderContract databaseBuilder(String name) =>
      _$ProductDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ProductDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ProductDatabaseBuilder(null);
}

class _$ProductDatabaseBuilder implements $ProductDatabaseBuilderContract {
  _$ProductDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ProductDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ProductDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ProductDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ProductDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ProductDatabase extends ProductDatabase {
  _$ProductDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` INTEGER NOT NULL, `quantity` INTEGER NOT NULL, `name` TEXT NOT NULL, `price` REAL NOT NULL, `image` TEXT NOT NULL, `category` TEXT NOT NULL, `description` TEXT NOT NULL, `rating` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'quantity': item.quantity,
                  'name': item.name,
                  'price': item.price,
                  'image': item.image,
                  'category': item.category,
                  'description': item.description,
                  'rating': _ratingConverter.encode(item.rating)
                }),
        _productUpdateAdapter = UpdateAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'quantity': item.quantity,
                  'name': item.name,
                  'price': item.price,
                  'image': item.image,
                  'category': item.category,
                  'description': item.description,
                  'rating': _ratingConverter.encode(item.rating)
                }),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'id': item.id,
                  'quantity': item.quantity,
                  'name': item.name,
                  'price': item.price,
                  'image': item.image,
                  'category': item.category,
                  'description': item.description,
                  'rating': _ratingConverter.encode(item.rating)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final UpdateAdapter<Product> _productUpdateAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Future<List<Product>> getProductById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Product WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int,
            quantity: row['quantity'] as int,
            name: row['name'] as String,
            price: row['price'] as double,
            category: row['category'] as String,
            description: row['description'] as String,
            image: row['image'] as String,
            rating: _ratingConverter.decode(row['rating'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> updateQuantity(
    int id,
    int quantity,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Product SET quantity = ?2 WHERE id = ?1',
        arguments: [id, quantity]);
  }

  @override
  Future<void> insertProduct(Product product) async {
    await _productInsertionAdapter.insert(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await _productUpdateAdapter.update(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProduct(Product product) async {
    await _productDeletionAdapter.delete(product);
  }
}

// ignore_for_file: unused_element
final _ratingConverter = RatingConverter();
