import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/Redacteur.dart';

class DatabaseManager {
  static Database? _database;

  static Future<Database> initDB() async {
    if (_database != null) return _database!;

    final dbDir = await getDatabasesPath();
    final path = join(dbDir, 'redacteur.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE redacteur(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT,
            prenom TEXT,
            email TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // insérer un rédacteur
  static Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await initDB();
    return await db.insert('redacteur', redacteur.toMap());
  }

  //Récupérer tous les rédacteurs
  static Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('redacteur');
    return List.generate(maps.length, (i) {
      return Redacteur(
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        prenom: maps[i]['prenom'],
        email: maps[i]['email'],
      );
    });
  }

  //Mettre à jour les rédacteurs
  static Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await initDB();
    return await db.update(
      'redacteur',
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id],
    );
  }

  //Supprimer un rédacteur
  static Future<int> deleteRedacteur(int id) async {
    final db = await initDB();
    return await db.delete('redacteur', where: 'id = ?', whereArgs: [id]);
  }
}
