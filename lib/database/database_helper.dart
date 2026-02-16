import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/student.dart';
import '../models/class_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ev_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';

    await db.execute('''
      CREATE TABLE classes (
        id $idType,
        name $textType,
        createdAt $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE roll_numbers (
        id $idType,
        classId $intType,
        rollNumber $intType,
        isCustom $intType,
        FOREIGN KEY (classId) REFERENCES classes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE students (
        id $idType,
        classId $intType,
        rollNumber $intType,
        name $textTypeNullable,
        fatherName $textTypeNullable,
        contact $textTypeNullable,
        fatherContact $textTypeNullable,
        address $textTypeNullable,
        comments $textTypeNullable,
        behaviorColor $intType,
        imagePath $textTypeNullable,
        createdAt $textType,
        updatedAt $textType,
        FOREIGN KEY (classId) REFERENCES classes (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id $idType,
        pinCode $textTypeNullable,
        isDarkMode $intType,
        language $textType
      )
    ''');

    await db.insert('settings', {
      'pinCode': null,
      'isDarkMode': 0,
      'language': 'en',
    });

    // Insert default classes
    for (var className in [
      'FE-1', 'FE-2', 'FE-3', 'FE-4',
      'SE-1', 'SE-2', 'SE-3', 'SE-4',
      'DE-1', 'DE-2', 'DE-3', 'DE-4',
    ]) {
      final classId = await db.insert('classes', {
        'name': className,
        'createdAt': DateTime.now().toIso8601String(),
      });

      for (var i = 1; i <= 50; i++) {
        await db.insert('roll_numbers', {
          'classId': classId,
          'rollNumber': i,
          'isCustom': 0,
        });
      }
    }
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE students ADD COLUMN imagePath TEXT');
      await db.execute('ALTER TABLE students ADD COLUMN fatherContact TEXT');
    }
  }

  Future<List<ClassModel>> getAllClasses() async {
    final db = await instance.database;
    final result = await db.query('classes', orderBy: 'id ASC');
    return result.map((json) => ClassModel.fromJson(json)).toList();
  }

  Future<List<int>> getRollNumbers(int classId) async {
    final db = await instance.database;
    final result = await db.query(
      'roll_numbers',
      where: 'classId = ?',
      whereArgs: [classId],
      orderBy: 'rollNumber ASC',
    );
    return result.map((e) => e['rollNumber'] as int).toList();
  }

  Future<int> addCustomRollNumber(int classId, int rollNumber) async {
    final db = await instance.database;
    return await db.insert('roll_numbers', {
      'classId': classId,
      'rollNumber': rollNumber,
      'isCustom': 1,
    });
  }

  Future<int> deleteRollNumber(int classId, int rollNumber) async {
    final db = await instance.database;
    await db.delete(
      'students',
      where: 'classId = ? AND rollNumber = ?',
      whereArgs: [classId, rollNumber],
    );
    return await db.delete(
      'roll_numbers',
      where: 'classId = ? AND rollNumber = ?',
      whereArgs: [classId, rollNumber],
    );
  }

  Future<Student?> getStudent(int classId, int rollNumber) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'classId = ? AND rollNumber = ?',
      whereArgs: [classId, rollNumber],
    );
    if (result.isNotEmpty) {
      return Student.fromJson(result.first);
    }
    return null;
  }

  Future<int> insertStudent(Student student) async {
    final db = await instance.database;
    return await db.insert('students', student.toJson());
  }

  Future<int> updateStudent(Student student) async {
    final db = await instance.database;
    return await db.update(
      'students',
      student.toJson(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<List<Student>> getStudentsByColor(int classId, int color) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'classId = ? AND behaviorColor = ?',
      whereArgs: [classId, color],
      orderBy: 'rollNumber ASC',
    );
    return result.map((json) => Student.fromJson(json)).toList();
  }

  Future<List<Student>> getAllStudentsInClass(int classId) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'classId = ?',
      whereArgs: [classId],
      orderBy: 'rollNumber ASC',
    );
    return result.map((json) => Student.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>?> getSettings() async {
    final db = await instance.database;
    final result = await db.query('settings', limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateSettings(Map<String, dynamic> settings) async {
    final db = await instance.database;
    return await db.update('settings', settings, where: 'id = ?', whereArgs: [1]);
  }

  Future<void> exportDatabase(String path) async {
    final db = await instance.database;
    await db.close();
    // Copy database file logic here
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
