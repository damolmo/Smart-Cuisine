import 'package:flutter/material.dart';
import '../../exports.dart';

class RecipeNameBanner extends StatelessWidget{
  @override
  const RecipeNameBanner({
    required this.viewModel,
    super.key,
});

  final RecipeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) *  0.1,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) *  0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) *  0.05,
        bottom: getDeviceHeight(context) * 0.025
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)],
      ),
      child: Row(
        children: [
          const Spacer(),
          Text(viewModel.recipes[0].recipeName, style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontSize: getDeviceWidth(context) *  0.055, fontWeight: FontWeight.bold),),
          const Spacer(),
        ],
      ),
    );
  }

}