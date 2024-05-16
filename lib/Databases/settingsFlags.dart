import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Settingsflags{

  Settingsflags({
    required this.settingName,
    required this.settingDescription,
    required this.settingValue,
    required this.settingIcon
});

  final String settingName;
  final String settingDescription;
  final String settingValue;
  final int settingIcon;

  static const settingsTable = """
    CREATE TABLE IF NOT EXISTS settings(
      settingName TEXT PRIMARY KEY,
      settingDescription TEXT,
      settingValue TEXT,
      settingIcon INTEGER);
  """;

  Map<String,dynamic> toMap() => {"settingName" : settingName, "settingDescription" : settingDescription, "settingValue" : settingValue, "settingIcon" : settingIcon};
  factory Settingsflags.fromMap(Map<String,dynamic> map) =>
    Settingsflags(
        settingName: map["settingName"],
        settingDescription: map["settingDescription"],
        settingValue: map["settingValue"],
        settingIcon: map["settingIcon"]);

  static createSettingsTable() async {
    // A static method that allow us to create the setting table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(settingsTable));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(settingsTable));
    }
  }

  static insertSettingIntoTable(Settingsflags setting) async {
    // A static method that allow us to insert a new setting flag
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.insert("settings", setting.toMap());
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.insert("settings", setting.toMap());
    }
  }

  static updateExistingFlag(Settingsflags setting) async {
    // A static method that allow us to update an existing system flag
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.update("settings", setting.toMap(), where: "settingName = ?", whereArgs: [setting.settingName]);
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.update("settings", setting.toMap(), where: "settingName = ?", whereArgs: [setting.settingName]);
    }
  }

  static rawSettingToInstance(List<Map<String,dynamic>> rawSettings, List<Settingsflags> settings){
    for (Map<String,dynamic> rawSetting in rawSettings){
      settings.add(Settingsflags.fromMap(rawSetting));
    }

    return settings;
  }


  static Future<List<Settingsflags>> retrieveExistingSettings() async {
    // A static method that retrieves a full list of setting flags
    List<Settingsflags> settings = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      settings = rawSettingToInstance(await db.query("settings"), settings);
    } else {
      final Database db = await openDatabase("cuisine.db");
      settings = rawSettingToInstance(await db.query("settings"), settings);
    }

    return settings;
  }

  static Future<List<Settingsflags>> retrieveSpecificSetting(String name) async {
    // A static method that retrieves a full list of setting flags
    List<Settingsflags> settings = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      settings = rawSettingToInstance(await db.query("settings", where: "settingName = ?", whereArgs: [name]), settings);
    } else {
      final Database db = await openDatabase("cuisine.db");
      settings = rawSettingToInstance(await db.query("settings", where: "settingName = ?", whereArgs: [name]), settings);
    }

    return settings;

  }

}