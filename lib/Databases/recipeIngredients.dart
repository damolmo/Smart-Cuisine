import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class RecipeIngredients{

  RecipeIngredients({
    required this.recipeName,
    required this.recipeIngredient
});

  final String recipeName;
  final String recipeIngredient;

  static const recipeIngredientTable = """
    CREATE TABLE IF NOT EXISTS recipeIngredients(
      ID TEXT PRIMARY KEY,
      recipeName TEXT,
      recipeIngredient TEXT,
      FOREIGN KEY(recipeName) REFERENCES recipes(recipeName)
    );
  """;

  Map<String,dynamic> toMap() => {"recipeName": recipeName, "recipeIngredient" : recipeIngredient};
  factory RecipeIngredients.fromMap(Map<String,dynamic> map) =>
    RecipeIngredients(recipeName: map["recipeName"], recipeIngredient: map["recipeIngredient"]);

  static createRecipesTable() async {
    // A static method that creates the recipe-ingredients table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(recipeIngredientTable));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(recipeIngredientTable));
    }
  }

  static insertRecipeIntoTable(RecipeIngredients ingredient) async {
    // A static method that inserts a new ingredient into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.insert("recipeIngredients", ingredient.toMap());
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.insert("recipeIngredients", ingredient.toMap());
    }
  }

  static deleteIngredientsRecipe(String recipe) async {
    // A static method that allow us to drop ingredients from a no longer existing recipe
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.delete("recipeIngredients", where: "recipeName = ?", whereArgs: [recipe]);
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.delete("recipeIngredients", where: "recipeName = ?", whereArgs: [recipe]);
    }
  }

  static dropIngredientsTable() async {
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipeIngredients"));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipeIngredients"));
    }
  }

  static rawIngredientToInstance(List<Map<String,dynamic>> rawIngredients, List<RecipeIngredients> ingredients){
    for (Map<String,dynamic> rawIngredient in rawIngredients){
      ingredients.add(RecipeIngredients.fromMap(rawIngredient));
    }
    return ingredients;
  }

  static Future<List<RecipeIngredients>> retrieveExistingIngredients(String recipe) async {
    // A static method that retrieves all ingredients for a recipe name
    List<RecipeIngredients> ingredients = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      ingredients = rawIngredientToInstance(await db.query("recipeIngredients", where: "recipeName = ?", whereArgs: [recipe]), ingredients);
    } else {
      final Database db = await openDatabase("cuisine.db");
      ingredients = rawIngredientToInstance(await db.query("recipeIngredients", where: "recipeName = ?", whereArgs: [recipe]), ingredients);
    }
    return ingredients;
  }


}