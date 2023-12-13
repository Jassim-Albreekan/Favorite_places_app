// Import the sqflite package, which provides a self-contained, high-reliability, embedded, SQL database engine
import 'package:sqflite/sqflite.dart' as sql;
// Import the path package, which provides common operations for manipulating paths
import 'package:path/path.dart' as path;

// Define the DBHelper class, which is a class that provides static methods to access and modify the database
class DBHelper {
  // Define a static async method named database, which returns a Future<sql.Database> object
  // This method creates or opens the database file and returns a reference to it
  static Future<sql.Database> database() async {
    // Await the result of calling the getDatabasesPath method from the sql package, which returns the default databases directory on the device
    final dbPath = await sql.getDatabasesPath();
    // Return the result of calling the openDatabase method from the sql package and pass the path of the database file as an argument
    // This method opens an existing database or creates a new one if it does not exist
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      // Set the onCreate argument to a function that takes the db and version as arguments and returns a Future<void>
      // This function is called when the database is created for the first time and executes the SQL statement to create the table
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT,loc_lat REAL,loc_lng REAL, address TEXT)');
      },
      // Set the version argument to 1, which defines the current version of the database schema
      version: 1,
    );
  }

  // Define a static async method named insert, which takes a String argument named table and a Map<String,Object> argument named data and returns a Future<void>
  // This method inserts a new row into the given table with the given data
  static Future<void> insert(String table, Map<String, Object> data) async {
    // Await the result of calling the database method and assign it to a final variable named db
    // This variable holds the reference to the database
    final db = await DBHelper.database();
    // Call the insert method from the db object and pass the table, data, and conflictAlgorithm as arguments
    // This method inserts the data into the table and handles any conflicts by replacing the existing row
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Define a static async method named getData, which takes a String argument named table and returns a Future<List<Map<String,dynamic>>>
  // This method queries the given table and returns a list of maps that contain the data of each row
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // Await the result of calling the database method and assign it to a final variable named db
    // This variable holds the reference to the database
    final db = await DBHelper.database();
    // Return the result of calling the query method from the db object and pass the table as an argument
    // This method returns a list of maps that contain the data of each row in the table
    return db.query(table);
  }
}
