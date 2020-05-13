import 'dart:async';
import 'dart:io';

import 'package:flutterapp/models/Contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String DB_NAME = "contacts.db";
  static const String TABLE_CONTACT = "contact";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_MOBILE = "mobile";
  static const String COLUMN_LANDLINE = "Landline";
  static const String COLUMN_IMAGE = "image";
  static const String COLUMN_FAV = "fav";

  DbHelper._internal();

  static final DbHelper dbHelper = DbHelper._internal();

  Database _db;

  Future<Database> get db async {
    print("database getter called");
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
      Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + DB_NAME;
    var dbContacts = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbContacts;
  }

  void _createDb(Database db, int newVersion) async {
    print("creating new db table ................");
    await db
        .execute("CREATE TABLE $TABLE_CONTACT($COLUMN_ID INTEGER PRIMARY KEY,"
            " $COLUMN_NAME TEXT,"
            " $COLUMN_MOBILE TEXT,"
            " $COLUMN_LANDLINE TEXT,"
            " $COLUMN_IMAGE TEXT,"
            " $COLUMN_FAV INTEGER)");
  }

  // Function to insert data into db
  Future<Contact> insertContact(Contact contact) async {
    Database db = await this.db;
    contact.id = await db.insert(TABLE_CONTACT, contact.toMap());
    return contact;
  }

  //  Function to update the contact in database
  Future<int> updateContact(Contact contact) async {
    final db = await this.db;
    var result = await db.update(
      TABLE_CONTACT,
      contact.toMap(),
      where: "id = ?",
      whereArgs: [contact.id],
    );

    print("result for updation is " + result.toString());
    print("data updated for " + contact.id.toString());
    return result;
  }

  // Function to delete contact from database
  Future<int> deleteContact(int id) async {
    final db = await this.db;

    return await db.delete(
      TABLE_CONTACT,
      where: "$COLUMN_ID = ?",
      whereArgs: [id],
    );
  }

  // Function to get list of contacts
  Future<List<Contact>> getContacts() async {
    final db = await this.db;

    var foods = await db.query(TABLE_CONTACT, orderBy: '$COLUMN_ID ASC');

    List<Contact> contactList = List<Contact>();

    foods.forEach((currentContact) {
      Contact contact = Contact.fromMap(currentContact);

      contactList.add(contact);
    });

    return contactList;
  }
}
