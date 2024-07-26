import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'bytebank.db';

  static Future<void> deleteDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    // Deletando o banco de dados
    await deleteDatabase(path);
    print('Database deleted');
  }

  static Future<void> createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    // Criando um novo banco de dados
    await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Criação das tabelas e dados iniciais
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            account_number INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE transactions (
            id TEXT PRIMARY KEY,
            value REAL,
            contact_id INTEGER,
            FOREIGN KEY (contact_id) REFERENCES contacts (id)
          )
        ''');
      },
    );

    print('New database created');
  }

  static Future<void> resetDatabase() async {
    await deleteDb();
    await createDatabase();
  }
}
