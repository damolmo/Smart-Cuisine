import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class RecipeInstructions{

  RecipeInstructions({
    required this.recipeName,
    required this.recipeStep
});

  final String recipeName;
  final String recipeStep;

  static const recipeInstructionsTable = """
    CREATE TABLE IF NOT EXISTS recipeInstructions(
      ID TEXT PRIMARY KEY,
      recipeName TEXT,
      recipeStep TEXT,
      FOREIGN KEY(recipeName) REFERENCES recipes(recipeName)
    );
  """;

  Map<String,dynamic> toMap() => {"recipeName" : recipeName, "recipeStep" : recipeStep};
  factory RecipeInstructions.fromMap(Map<String,dynamic> map) =>
    RecipeInstructions(recipeName: map["recipeName"], recipeStep: map["recipeStep"]);

  static createRecipeInstructionsTable() async {
    // A static method that allow us to create the recipe-instructions table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(recipeInstructionsTable));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute(recipeInstructionsTable));
    }
  }

  static insertRecipeInstruction(RecipeInstructions instruction) async {
    // A static method that allow us to insert a new instruction into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.insert("recipeInstructions", instruction.toMap());
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.insert("recipeInstructions", instruction.toMap());
    }
  }

  static deleteInstructionsRecipe(String recipe) async {
    // A static method that delete the isntructions for a no longer existing recipe
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.delete("recipeInstructions", where: "recipeName = ?", whereArgs: [recipe]);
    } else {

      final Database db = await openDatabase("cuisine.db");
      db.delete("recipeInstructions", where: "recipeName = ?", whereArgs: [recipe]);

    }
  }

  static dropInstructionsTable() async {
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipeInstructions"));
    } else {
      final Database db = await openDatabase("cuisine.db");
      db.transaction((txn) => txn.execute("DROP TABLE IF EXISTS recipeInstructions"));
    }
  }

  static rawInstructionToInstance(List<Map<String,dynamic>> rawInstructions, List<RecipeInstructions> instructions){
    for (Map<String,dynamic> rawInstruction in rawInstructions){
      instructions.add(RecipeInstructions.fromMap(rawInstruction));
    }
    return instructions;
  }

  static Future<List<RecipeInstructions>> retrieveRecipeInstructions(String recipe) async {
    // A static method that allow us to retrieve instructions/steps for a recipe

    List<RecipeInstructions> instructions = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("cuisine.db");
      instructions = rawInstructionToInstance(await db.query("recipeInstructions", where: "recipeName = ?", whereArgs: [recipe]), instructions);
    } else {
      final Database db = await openDatabase("cuisine.db");
      instructions = rawInstructionToInstance(await db.query("recipeInstructions", where: "recipeName = ?", whereArgs: [recipe]), instructions);
    }

    return instructions;
  }


}