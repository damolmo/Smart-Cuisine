import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class CategoriesRecipe {

  CategoriesRecipe({
    required this.categoryImage,
    required this.categoryName
});

  final String categoryImage;
  final String categoryName;

  static const categoriesTable = """
    CREATE TABLE IF NOT EXISTS categoriesRecipes(
      categoryName TEXT PRIMARY KEY,
      categoryImage TEXT);
  """;

  Map<String,dynamic> toMap() => {"categoryName" : categoryName, "categoryImage" : categoryImage};
  factory CategoriesRecipe.fromMap(Map<String,dynamic> map) =>
      CategoriesRecipe(categoryImage: map["categoryImage"], categoryName: map["categoryName"]);

  static createCategoriesTable() async {
    // A static method that allow us to create the categories table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    }
  }

  static insertCategoryIntoTable(CategoriesRecipe category) async {
    // A static method to insert a category into the categories table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.insert("categoriesRecipes", category.toMap());
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.insert("categoriesRecipes", category.toMap());
    }
  }

  static rawCategoryToInstance(List<Map<String,dynamic>> rawCategories, List<CategoriesRecipe> categories){
    List<CategoriesRecipe> categories  = [];
    for (Map<String,dynamic> rawCategory in rawCategories){
      categories.add(CategoriesRecipe.fromMap(rawCategory));
    }

    return categories;
  }

  static Future<List<CategoriesRecipe>> retrieveCurrentCategories() async {
    // A static method that retrieves existing categories on database
    List<CategoriesRecipe> categories = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      categories = rawCategoryToInstance(await db.query("categoriesRecipes"), categories);
    } else {
      final Database db = await openDatabase("cuisine.db");
      categories = rawCategoryToInstance(await db.query("categoriesRecipes"), categories);
    }

    return categories;
  }

}