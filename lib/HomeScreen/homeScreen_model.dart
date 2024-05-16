import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import '../exports.dart';

class HomeScreenModel extends BaseViewModel implements Initialisable {

  @override
  HomeScreenModel({
    required this.context,
    this.choosedMenuEntry = 0,
});


  final BuildContext context;

  // Variables to be used for Gemini
  final geminiModelType = "gemini-pro";
  List<Content> content = [Content.text("")];
  late ChatSession chat;
  late GenerativeModel model;
  String loadingMessage = "";
  bool isGeminiLoading = false;
  bool isDataSaved = false;

  TextEditingController dishNameField = TextEditingController(text: "");
  TextEditingController comensalesNumberField = TextEditingController(text: "");
  String categoryName = "";
  String mapString = "";
  Map<String,dynamic> geminiMap = {};
  bool isModeSelected = false;
  bool isCategoryDish = false;
  bool isUserTyping = false;
  int choosedMenuEntry = 0;
  bool isDarkModeEnabled = false;
  List<Settingsflags> settings = [];

  // Menus data
  bool isDishField = true;
  bool isComensalesField = false;

  // Recipes Data
  List<CategoriesRecipe> categories = [];
  List<Recipes> recipes = [];
  List<RecipeIngredients> ingredients = [];
  List<RecipeInstructions> instructions = [];

  @override
  void initialise(){
    getGeminiKey();
    getCurrentCategories(); // Get categories
    returnExistingRecipes(); // Get exiting recipes
    getCurrentTheme();
  }

  TextInputType getKeyboardType() => isDishField ? TextInputType.name : TextInputType.phone;

  void getGeminiKey() async {
    // A method that allow us to retrieve existing key on database
    List<Settingsflags> temp = [];

    try {
      temp = await Settingsflags.retrieveSpecificSetting("Gemini API Key");
      geminiApi = temp[0].settingValue;
      notifyListeners();
    } catch (e){
      // Nothing to do if an empty key is set
    }
  }

  void getCurrentTheme() async {
    // A method that read background theme from database if exists
    try{
      settings = await Settingsflags.retrieveSpecificSetting("Modo Oscuro");
      notifyListeners();
    } catch (e){
      // nothing to do, doesnt exists
    }

    if (settings.isNotEmpty){
      if (settings[0].settingValue == "true"){
        isDarkModeEnabled = true;
        notifyListeners();
      } else {
        isDarkModeEnabled = false;
        notifyListeners();
      }
    }

  }

  void getUserContentByCategory() async {
    // A method that receives a user text and returns a user content for gemini
    content.clear(); // Avoid old data

    var text = "Quiero una receta para un ${categoryName} para ${comensalesNumberField.text} comensales, devuelveme los datos en un map formateado a string usando comillas dobles, que empiece por { y temrine en }, con las siguientes claves : 'Nombre', 'Ingredientes', 'Comensales', 'Instrucciones', y las claves Ingredientes y Instrucciones tendrán un array cuando tengan mas de un elemento";
    content.add(Content.text(text));
    notifyListeners();
  }

  void getUserContentByName() async {
    // A method that receives a user text and returns a user content for gemini
    content.clear(); // Avoid old data
    var text = "Quiero una receta de ${dishNameField.text} para ${comensalesNumberField.text} comensales, devuelveme los datos en un map formateado a string, que empiece por { y temrine en }, con las siguientes claves : 'Nombre', 'Ingredientes', 'Comensales', 'Instrucciones', y las claves Ingredientes y Instrucciones tendrán un array cuando tengan mas de un elemento";
    content.add(Content.text(text));
    notifyListeners();
  }

  getResponseData() async {
    // A method that saves a response data
    final model = GenerativeModel(model: geminiModelType, apiKey: geminiApi, generationConfig: GenerationConfig(maxOutputTokens:
    500));
    notifyListeners();
    var response = await model.generateContent(content);
    print(response.text);

    mapString = response.text.toString().replaceAll("```", "");
    geminiMap = json.decode(mapString);
    saveRecipeIntoDatabase();
  }


  addRecipeIntoTable() async {
    // Adds a new recipe
    Recipes.createRecipesTable();
    Recipes.insertRecipeIntoTable(
        Recipes(
            recipeName: geminiMap["Nombre"],
            recipeCategory: categoryName,
            recipeComensales: geminiMap["Comensales"].toString())
    );
  }

  addRecipeIngredientsIntoTable() async {
    // Add new recipe ingredients
    RecipeIngredients.createRecipesTable();

    try {
      for (String ingredient in geminiMap["Ingredientes"]){
        RecipeIngredients.insertRecipeIntoTable(
            RecipeIngredients(
                recipeName: geminiMap["Nombre"],
                recipeIngredient: ingredient)
        );
      }
    } catch (e){
      // There's only one ingredient
      RecipeIngredients.insertRecipeIntoTable(
        RecipeIngredients(recipeName: geminiMap["Nombre"], recipeIngredient: geminiMap["Ingredientes"])
      );
    }
  }

  addRecipeInstructionsIntoTable() async {
    // Add new recipe instructions
    RecipeInstructions.createRecipeInstructionsTable();

    try {
      for (String instruction in geminiMap["Instrucciones"]){
        RecipeInstructions.insertRecipeInstruction(
            RecipeInstructions(
                recipeName: geminiMap["Nombre"],
                recipeStep: instruction)
        );
      }
    } catch (e){
      // There's only a step..
      RecipeInstructions.insertRecipeInstruction(
          RecipeInstructions(recipeName: geminiMap["Nombre"], recipeStep: geminiMap["Instrucciones"]));
    }

    isDataSaved = true;
    notifyListeners();
  }

  saveRecipeIntoDatabase() async {
    // A method that allow us to feed database with gemini responses

    // Add recipe
   addRecipeIntoTable();

    // Add recipe ingredients
    addRecipeIngredientsIntoTable();

    // Add recipe instructions
    addRecipeInstructionsIntoTable();

  }

  void awaitForResponse() async {
    // A method that will await for a gemini response
    CountdownTimer timer = CountdownTimer(const Duration(seconds: 30), const Duration(seconds: 1));
    var listener = timer.listen(null);
    int counter = 0;

    listener.onData((data){
      // Await enought time for a gemini response
      // If response is empty after 10 seconds, call gemini again
      if (geminiMap.isEmpty && !isDataSaved){
        counter +=1;
        if (counter >= 10 && geminiMap.isEmpty){
          getResponseData(); // Call gemini again
        }
      } else if (isGeminiLoading) {
        counter = 0;
        isGeminiLoading = false;
        returnExistingRecipes();
        notifyListeners();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeScreenView(recipeName: geminiMap["Nombre"], isDarkModeEnabled: isDarkModeEnabled,)));
      }
    });


  }

  void getCurrentCategories() async {
    // A method that allow us to retrieve latest categories on database!
    try {
      categories = await CategoriesRecipe.retrieveCurrentCategories();
      notifyListeners();
    } catch (e){
      // Failed to retrieve category data, insert data
      CategoriesRecipe.createCategoriesTable();
      CategoriesData.insertCategories();
      categories = await CategoriesRecipe.retrieveCurrentCategories();
      notifyListeners();
    }
  }

  void returnExistingRecipes() async {
    // A method that reads the database and returns a list of recipes

    try {
      recipes = await Recipes.retrieveExistingRecipes();
      recipes = recipes.reversed.toList();
      notifyListeners();
    } catch (e){
      // Nothing to do, no existing recipes :)
    }
  }

  Color getRandomColor() {
    // Gets a random color for a leading list

    List<Color> colors = [Colors.black, Colors.blue, Colors.red, Colors.green, Colors.pink, Colors.purple, Colors.brown, Colors.orange];

    return colors[Random().nextInt(colors.length)];

  }

}