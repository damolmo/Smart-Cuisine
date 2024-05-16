import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class InsertKeyField extends StatelessWidget{
  @override
  InsertKeyField({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.07,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.46,
        bottom: getDeviceHeight(context) * 0.46
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.8) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) :  Colors.black.withOpacity(0.8), blurStyle: BlurStyle.normal, blurRadius: 99.0, spreadRadius: 2.0)]
      ),
      child: TextField(

        onSubmitted: (_){
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          viewModel.choosedSettingOption = 99;
          viewModel.notifyListeners();
          viewModel.insertNewKey();
        },

        onTapOutside: (_){
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          viewModel.choosedSettingOption = 99;
        },

        textAlign: TextAlign.center,
        style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06),
          hintText: "Introduce clave Gemini",
        ),
        controller: viewModel.keyField,

      ),

    );
  }

}