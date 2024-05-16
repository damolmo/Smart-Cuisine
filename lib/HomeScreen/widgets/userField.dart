import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class UserField extends StatelessWidget{
  @override
  const UserField({
    required this.viewModel,
});

  final HomeScreenModel viewModel;

  @override
  Widget build (BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) *  0.1,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) *  0.05,
        right: getDeviceWidth(context) * 0.05,
        top: viewModel.isUserTyping ? getDeviceHeight(context) *  0.45 : getDeviceHeight(context) *  0.7,
        bottom: viewModel.isUserTyping ? getDeviceHeight(context) *  0.45 :getDeviceHeight(context) *  0.2
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
        borderRadius: BorderRadius.circular(25)
      ),
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) *  0.08, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: viewModel.isDishField ? "Introduce un plato" : "Introduce los comensales",
          hintStyle: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) *  0.07, fontWeight: FontWeight.bold)
        ),
        onTap: (){
          viewModel.isUserTyping = true;
          viewModel.notifyListeners();
        },

        onEditingComplete: (){
          viewModel.isUserTyping = false;

          if (viewModel.isCategoryDish){
            // Call gemini!!
            viewModel.awaitForResponse();
            viewModel.isGeminiLoading = true;
            viewModel.getUserContentByCategory();
            viewModel.getResponseData();

            // Restore default values for next query
            viewModel.isModeSelected = false;
            viewModel.dishNameField.text = "";
            viewModel.isDishField = true;
            viewModel.isCategoryDish = false;
            viewModel.isComensalesField = false;
            viewModel.categoryName = "";
            viewModel.comensalesNumberField.text = "";
            viewModel.notifyListeners();
          } else {
            if (viewModel.isDishField && !viewModel.isComensalesField){
              viewModel.isDishField = false;
              viewModel.isComensalesField = true;
              viewModel.notifyListeners();
            } else if (!viewModel.isDishField && viewModel.isComensalesField){
              viewModel.isComensalesField = false;

              // Call gemini!!
              viewModel.awaitForResponse();
              viewModel.isGeminiLoading = true;
              viewModel.getUserContentByName();
              viewModel.getResponseData();
              viewModel.notifyListeners();

              // Revert settings
              viewModel.isDishField = true;
              viewModel.isComensalesField = false;
              viewModel.dishNameField.text = "";
              viewModel.comensalesNumberField.text = "";
              viewModel.isModeSelected = false;
              viewModel.notifyListeners();
            }
          }
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },

        controller: viewModel.isDishField ? viewModel.dishNameField : viewModel.comensalesNumberField,
        keyboardType: viewModel.getKeyboardType(),
      ),
    );
  }
}