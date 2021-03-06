import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:makeup_expires2/model/product.dart';

class ProductsDatabase {
  static final ProductsDatabase instance = ProductsDatabase._init();

  static Database? _database;

  ProductsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableProducts ( 
  ${ProductFields.id} $idType, 
  ${ProductFields.title} $textType,
  ${ProductFields.description} $textType,
  ${ProductFields.time} $textType
  )
''');
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;

    final id = await db.insert(tableProducts, product.toJson());
    return product.copy(id: id);
  }

  Future<Product> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProducts,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;

    final orderBy = '${ProductFields.time} ASC';

    final result = await db.query(tableProducts, orderBy: orderBy);

    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;

    return db.update(
      tableProducts,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableProducts,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
