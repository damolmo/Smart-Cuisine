import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cuicine/Data/settingsFlagsData.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class SettingsScreenModel extends HomeScreenModel implements Initialisable{
 @override
 SettingsScreenModel({
   required this.context,
   required this.isDarkModeEnabled,
}) : super(context: context);

 final BuildContext context;
 final bool isDarkModeEnabled;
 List<Settingsflags> settings = [];
 int choosedSettingOption = 99;
 int choosedMenuEntry = 2;
 TextEditingController keyField = TextEditingController(text: "");

  @override
  void initialise(){
    retrieveLatestSettings();
  }

  void retrieveLatestSettings() async {
    // A method to get settings data
    try {
      settings = await Settingsflags.retrieveExistingSettings();
      notifyListeners();
    } catch (e){
      SettingsData.insertNewSettings();
      settings = await Settingsflags.retrieveExistingSettings();
      notifyListeners();
    }
  }

  void changeCurrentSettings(String value) async {
    // Update background Theme
    Settingsflags.updateExistingFlag(
      Settingsflags(
          settingName: "Modo Oscuro",
          settingDescription: SettingsData.settingMap["Modo Oscuro"]["settingDescription"],
          settingValue: value,
          settingIcon: SettingsData.settingMap["Modo Oscuro"]["settingIcon"])
    );

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreenView(choosedMenuEntry: 0,)));

  }

  void dropAllData() async {
    // A method that drops all existing data
    // This is a high risk operation
    RecipeInstructions.dropInstructionsTable();
    RecipeIngredients.dropIngredientsTable();
    Recipes.dropRecipesTable();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreenView(choosedMenuEntry: 0,)));

  }

 void insertNewKey() async {
   // Allow users to insert key into database

   if (keyField.text.length > 5){
     // Key isn't empty
     // Since we don't have a way to validate it, user will be push to home screen
     // Anyway, a key can be set from settings if needed

     Settingsflags.updateExistingFlag(
         Settingsflags(
             settingName: settings[2].settingName,
             settingDescription: settings[2].settingDescription,
             settingValue: keyField.text,
             settingIcon: settings[2].settingIcon)
     );

     // Go to home screen :)

   }
 }

}