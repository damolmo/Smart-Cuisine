import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class KeyField extends StatelessWidget{
  @override
  KeyField({
    required this.viewModel,
    super.key});

  final LoginScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) * 0.07,
      margin: EdgeInsets.only(
        top: viewModel.isUserTyping ?  getDeviceHeight(context) * 0.2 : getDeviceHeight(context) * 0.88,
        bottom: viewModel.isUserTyping ?  getDeviceHeight(context) * 0.7 : getDeviceHeight(context) * 0.05,
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 5.0, blurStyle: BlurStyle.normal, spreadRadius: 2.0)]
      ),
      child: TextField(

        onTap: (){
          viewModel.isUserTyping = true;
          viewModel.notifyListeners();
        },

        onTapOutside: (_){
          viewModel.isUserTyping = false;
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          viewModel.notifyListeners();
        },

        onSubmitted: (_){
          // Check key
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          viewModel.insertNewKey();
        },
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) * 0.07, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) * 0.07, fontWeight: FontWeight.bold),
          hintText: "Introduce una clave"
        ),
        controller: viewModel.keyField,
      ),
    );
  }
}