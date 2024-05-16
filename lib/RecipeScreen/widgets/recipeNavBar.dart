import 'package:flutter/material.dart';
import '../../exports.dart';

class RecipeNavBar extends StatelessWidget{
  @override
  const RecipeNavBar({
    required this.viewModel,
    super.key
});

  final RecipeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) *  0.1,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) *  0.05,
        right: getDeviceWidth(context) *  0.05,
        top: getDeviceHeight(context) * 0.85,
        bottom: getDeviceHeight(context) *  0.05
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 4.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)]
      ),
      child: Row(
        children: [
          // Return Icon
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: getDeviceHeight(context) *  0.08,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.01,
              bottom: getDeviceHeight(context) * 0.01,
              right: getDeviceWidth(context) * 0.05,
              left: getDeviceWidth(context) * 0.025
            ),
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },

              icon: Icon(Icons.arrow_back_rounded, color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, size: 45),
            ),
          ),

          // Delete Icon
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: getDeviceHeight(context) *  0.08,
            margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.01,
                bottom: getDeviceHeight(context) * 0.01,
                right: getDeviceWidth(context) * 0.05
            ),
            child: IconButton(
              onPressed: (){
               viewModel.deleteAReceipe();
              },

              icon: Icon(Icons.delete_rounded, color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, size: 45),
            ),
          ),

          // Dark Mode Icon
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: getDeviceHeight(context) *  0.08,
            margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.01,
                bottom: getDeviceHeight(context) * 0.01,
                right: getDeviceWidth(context) * 0.025
            ),
            child: IconButton(
              onPressed: (){
               viewModel.isDarkModeEnabled ? viewModel.isDarkModeEnabled = false : viewModel.isDarkModeEnabled = true;
               viewModel.notifyListeners();
              },

              icon: Icon(viewModel.isDarkModeEnabled ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, size: 45),
            ),
          ),
        ],
      )
    );
  }


}