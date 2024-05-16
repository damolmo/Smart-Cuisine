import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class RecipeScreenModel extends HomeScreenModel implements Initialisable{
  @override
  RecipeScreenModel({
    required this.recipeName,
    required this.context,
    required this.isDarkModeEnabled,
}) : super(context: context);

  bool isDarkModeEnabled;
  final BuildContext context;
  final String recipeName;
  List<Recipes> recipes = [];
  List<RecipeIngredients> ingredients = [];
  List<RecipeInstructions> instructions = [ ];

  @override
  void initialise(){
    retrieveDataLatest();
  }

  retrieveDataLatest() async {
    // Retrieve data for latest inserted recipe!
    recipes = await Recipes.retrieveSpecificRecipe(recipeName);
    ingredients = await RecipeIngredients.retrieveExistingIngredients(recipeName);
    instructions = await RecipeInstructions.retrieveRecipeInstructions(recipeName);
    notifyListeners();
  }

  deleteAReceipe() async {
    // Drop a recipe generate by gemini
    RecipeIngredients.deleteIngredientsRecipe(recipeName);
    RecipeInstructions.deleteInstructionsRecipe(recipeName);
    Recipes.dropRecipeFromTable(recipeName);

    // Return to previous screen, this recipe no longer exists!
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreenView()));
  }
}