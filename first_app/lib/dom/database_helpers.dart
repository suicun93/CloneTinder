import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../common/image_converters.dart';
import '../model/JSON_user.dart';

// database table and column names
final String tableUsers = 'users';
final String columnId = '_id';
final String columnNameTitle = 'name_title';
final String columnNameFirst = 'name_first';
final String columnNameLast = 'name_last';
final String columnImage = 'image';
final String columnEmail = 'email';
final String columnAddress = 'address';
final String columnPhone = 'phone';
final String columnUsername = 'username';

// data model class
class User {
	int id;
	String nameTitle, nameFirst, nameLast;
	String image, email, address, phone, username;
	
	User();
	
	User.fromJSON(UserBean userBean){
		this.nameTitle = userBean.name.title;
		this.nameFirst = userBean.name.first;
		this.nameLast = userBean.name.last;
		this.image = userBean.picture;
		this.email = userBean.email;
		this.address = userBean.location.street;
		this.phone = userBean.phone;
		this.username = userBean.username;
	}
	
	User.fromMap(Map<String, dynamic> map) {
		id = map[columnId];
		nameTitle = map[columnNameTitle];
		nameFirst = map[columnNameFirst];
		nameLast = map[columnNameLast];
		image = map[columnImage];
		email = map[columnEmail];
		address = map[columnAddress];
		phone = map[columnPhone];
		username = map[columnUsername];
	}
	
	// convenience method to create a Map from this User object
	Future<Map<String, dynamic>> toMap() async {
		String base64 = await ImageConverter.instance.imageToBase64(image);
		var map = <String, dynamic>{
			columnNameTitle: nameTitle,
			columnNameFirst: nameFirst,
			columnNameLast: nameLast,
			columnImage: base64,
			columnEmail: email,
			columnAddress: address,
			columnPhone: phone,
			columnUsername: username,
		};
		if (id != null) {
			map[columnId] = id;
		}
		return map;
	}
}

// singleton class to manage the database
class DatabaseHelper {
	
	// This is the actual database filename that is saved in the docs directory.
	static final _databaseName = "TinderDatabase2.db";
	
	// Increment this version when you need to change the schema.
	static final _databaseVersion = 1;
	
	// Make this a singleton class.
	DatabaseHelper._privateConstructor();
	
	static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
	
	// Only allow a single open connection to the database.
	static Database _database;
	
	Future<Database> get database async {
		if (_database != null) return _database;
		_database = await _initDatabase();
		return _database;
	}
	
	// open the database
	_initDatabase() async {
		// The path_provider plugin gets the right directory for Android or iOS.
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		String path = join(documentsDirectory.path, _databaseName);
		// Open the database. Can also add an onUpdate callback parameter.
		return await openDatabase(path,
				version: _databaseVersion,
				onCreate: _onCreate);
	}
	
	// SQL string to create the database
	Future _onCreate(Database db, int version) async {
		await db.execute('''
              CREATE TABLE $tableUsers (
                $columnId INTEGER PRIMARY KEY,
                $columnNameTitle TEXT NOT NULL,
                $columnNameFirst TEXT NOT NULL,
                $columnNameLast TEXT NOT NULL,
                $columnImage TEXT NOT NULL,
                $columnEmail TEXT NOT NULL,
                $columnAddress TEXT NOT NULL,
                $columnPhone TEXT NOT NULL,
                $columnUsername TEXT NOT NULL
              )
              ''');
	}
	
	// Database helper methods:
	
	Future<int> insert(User user) async {
		Database db = await database;
		Map<String, dynamic> maps = await user.toMap();
		int id = await db.insert(tableUsers, maps);
		return id;
	}
	
	Future<User> queryUserByID(int id) async {
		Database db = await database;
		List<Map> maps = await db.query(tableUsers,
				columns: [columnId,
					columnNameTitle,
					columnNameFirst,
					columnNameLast,
					columnImage,
					columnEmail,
					columnAddress,
					columnPhone,
					columnUsername
				],
				where: '$columnId = ?',
				whereArgs: [id]);
		if (maps.length > 0) {
			return User.fromMap(maps.first);
		}
		return null;
	}
	
	// queryAllUsers()
	Future<List<User>> queryUser() async {
		Database db = await database;
		List<Map> maps = await db.query(tableUsers,
				columns: [columnId,
					columnNameTitle,
					columnNameFirst,
					columnNameLast,
					columnImage,
					columnEmail,
					columnAddress,
					columnPhone,
					columnUsername
				]);
		var users = List<User>();
		maps.forEach((map) => users.add(User.fromMap(map)));
		return users;
	}
	
	Future<List<User>> read() async {
		DatabaseHelper helper = DatabaseHelper.instance;
		List<User> users = await helper.queryUser();
		return users;
	}
	
	save(User user) async {
		DatabaseHelper helper = DatabaseHelper.instance;
		await helper.insert(user);
	}
}