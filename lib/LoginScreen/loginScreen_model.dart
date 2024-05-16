import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_cuicine/Data/settingsFlagsData.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class LoginScreenModel extends BaseViewModel implements Initialisable{
  @override
  LoginScreenModel({
    required this.context
});

  final BuildContext context;
  bool isDarkModeEnabled = false;
  bool isUserTyping = false;
  TextEditingController keyField = TextEditingController(text: "");
  List<Settingsflags> settings = [];

  @override
  void initialise(){
    getCurrentSettings();
  }

  void getCurrentSettings() async {
    // A method that allow us to get current settings
    try{
      settings = await Settingsflags.retrieveSpecificSetting("Gemini API Key");
    } catch (e){
    }

    if (settings.isNotEmpty){
      if (settings[0].settingValue.length > 5){
        // Gemini Key exists
        navigateToHome();
      }
    } else {
      SettingsData.insertNewSettings();
      settings = await Settingsflags.retrieveSpecificSetting("Gemini API Key");
    }
  }

  void navigateToHome() async {
    // Navigate to home screen after validating the key
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreenView(choosedMenuEntry: 0,)));
  }

  void insertNewKey() async {
    // Allow users to insert key into database

    if (keyField.text.length > 5){
      // Key isn't empty
      // Since we don't have a way to validate it, user will be push to home screen
      // Anyway, a key can be set from settings if needed

      Settingsflags.updateExistingFlag(
        Settingsflags(
            settingName: settings[0].settingName,
            settingDescription: settings[0].settingDescription,
            settingValue: keyField.text,
            settingIcon: settings[0].settingIcon)
      );

      // Go to home screen :)
      navigateToHome();

    } else {
      notifyUserEmptyKey();
    }
  }

  void notifyUserEmptyKey() async {
    SnackBar snack = SnackBar(content: Text("Debes introducir una clave\nContacta al desarrollador\nde esta aplicación", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05),  textAlign: TextAlign.center,), behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

}