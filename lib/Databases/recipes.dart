import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class Recipes{

  Recipes({
    required this.recipeName,
    required this.recipeCategory,
    required this.recipeComensales
});

  final String recipeName;
  final String recipeCategory;
  final String recipeComensales;

  static const receipesTable = """
    CREATE TABLE IF NOT EXISTS recipes(
      recipeName TEXT PRIMARY KEY,
      recipeCategory TEXT,
      recipeComensales TEXT,
      FOREIGN KEY(recipeCategory) REFERENCES categories(CategoryName)
    );
  """;

  Map<String,dynamic> toMap() => {"recipeName": recipeName, "recipeCategory" : recipeCategory, "recipeComensales" : recipeComensales};
  factory Recipes.fromMap(Map<String,dynamic> map) =>
    Recipes(
        recipeName: map["recipeName"],
        recipeCategory: map["recipeCategory"],
        recipeComensales: map["recipeComensales"]);

  static createRecipesTable() async {
    // A static method that creates the receipes table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(receipesTable));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(receipesTable));
    }
  }

  static insertRecipeIntoTable(Recipes recipe) async {
    // A static methid that allow us to insert a new receipe into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.insert("recipes", recipe.toMap());
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.insert("recipes", recipe.toMap());
    }
  }

  static dropRecipeFromTable(String recipe) async {
    // A static method that allow us to drop a recipe from the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.delete("recipes", where: "recipeName = ?", whereArgs: [recipe]);
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.delete("recipes", where: "recipeName = ?", whereArgs: [recipe]);
    }
  }

  static dropRecipesTable() async {
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipes"));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipes"));
    }
  }

  static rawRecipeToInstance(List<Map<String,dynamic>> rawRecipes, List<Recipes> recipes){
    // Returns a full list of recipes
    for (Map<String,dynamic> rawRecipe in rawRecipes){
      recipes.add(Recipes.fromMap(rawRecipe));
    }

    return recipes;
  }

  static Future<List<Recipes>> retrieveExistingRecipes() async {
    // A static method that returns existing recipes for a category
    List<Recipes> recipes = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      recipes = rawRecipeToInstance(await db.query("recipes"), recipes);
    } else {
      final Database db = await openDatabase("cuisine.db");
      recipes = rawRecipeToInstance(await db.query("recipes"), recipes);
    }

    return recipes;
  }

  static Future<List<Recipes>> retrieveSpecificRecipe(String recipeName) async {
    // A static method that returns existing recipes for a category
    List<Recipes> recipes = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      recipes = rawRecipeToInstance(await db.query("recipes", where: "recipeName = ?", whereArgs: [recipeName]), recipes);
    } else {
      final Database db = await openDatabase("cuisine.db");
      recipes = rawRecipeToInstance(await db.query("recipes", where: "recipeName = ?", whereArgs: [recipeName]), recipes);
    }

    return recipes.reversed.toList();
  }


}