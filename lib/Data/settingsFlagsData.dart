import '../exports.dart';
import 'package:flutter/material.dart';

class SettingsData{

  static Map<String,dynamic> settingMap = {
    "Modo Oscuro" : {
      "settingValue" : "false",
      "settingDescription" : "Cambia el color de fondo",
      "settingIcon" : Icons.palette_rounded.codePoint
    },

    "Borrar datos" : {
      "settingValue" : "data",
      "settingDescription" : "Borra todas las recetas",
      "settingIcon" : Icons.delete_rounded.codePoint
    },

    "Gemini API Key" : {
      "settingValue" : "key",
      "settingDescription" : "La clave de uso de Gemini",
      "settingIcon" : Icons.key_rounded.codePoint
    },

    "Smart Cuisine" : {
      "settingValue" : "about",
      "settingDescription" : "Pulsa para ver el código fuente",
      "settingIcon" : Icons.info_rounded.codePoint
    },
  };

  static insertNewSettings() async {
    // A method to insert default settings into the table
    Settingsflags.createSettingsTable();

    for (String setting in settingMap.keys){
      Settingsflags.insertSettingIntoTable(
        Settingsflags(
            settingName: setting,
            settingDescription: settingMap[setting]["settingDescription"],
            settingValue: settingMap[setting]["settingValue"],
            settingIcon: settingMap[setting]["settingIcon"])
      );
    }
  }
}