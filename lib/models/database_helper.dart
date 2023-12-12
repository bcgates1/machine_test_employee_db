import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'employee_model.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'employee_database.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY,
        first_name TEXT,
        last_name TEXT,
        email TEXT,
        avatar TEXT
      )
    ''');
  }

  Future<void> addAllEmployees(List<EmployeeModel> employees) async {
    final db = await database;
    final batch = db.batch();

    for (var employee in employees) {
      batch.insert('employees', employee.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit();
  }

  Future<void> insertEmployee(EmployeeModel employee) async {
    final db = await database;
    await db.insert('employees', employee.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) {
      return EmployeeModel(
        id: maps[i]['id'],
        firstName: maps[i]['first_name'],
        lastName: maps[i]['last_name'],
        email: maps[i]['email'],
        avatar: maps[i]['avatar'],
      );
    });
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    final db = await database;
    await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> hasEmployees() async {
    final db = await database;
    final result = await db.query('employees');

    return result.isNotEmpty;
  }
}
