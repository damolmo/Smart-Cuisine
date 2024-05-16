import 'package:flutter/material.dart';
import '../../exports.dart';

class RecipeIngredientsList extends StatelessWidget{
  @override
  const RecipeIngredientsList({
    required this.viewModel
});

  final RecipeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceHeight(context) *  0.95,
      height: getDeviceHeight(context) *  0.4,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) *  0.025,
        right: getDeviceWidth(context) *  0.025,
        top: getDeviceHeight(context) *  0.2
      ),
      child: Column(
        children: [

          // Ingredients banner
          Container(
            width: getDeviceWidth(context) *  0.95,
            height: getDeviceHeight(context) *  0.075,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) *  0.025,
              bottom: getDeviceHeight(context) *  0.025
            ),
            decoration: BoxDecoration(
              color: viewModel.isDarkModeEnabled ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
            ),
            child: Row(
              children: [
                const Spacer(),
                Text("Ingredientes", style: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.07, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),
          ),

          // Ingredients list
          Container(
            width: getDeviceHeight(context) *  0.95,
            height: getDeviceHeight(context) *  0.25,
            child : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.ingredients.length,
            itemBuilder: (context, index){
              return Container(
                width: getDeviceWidth(context) *  0.4,
                height: getDeviceHeight(context) *  0.25,
                margin: EdgeInsets.only(
                    top: getDeviceHeight(context) *  0.025,
                    bottom: getDeviceHeight(context) *  0.025,
                    left: getDeviceWidth(context) *  0.05,
                    right: viewModel.ingredients.length -1 == index ?  getDeviceWidth(context) * 0.05 : 0.0
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), spreadRadius: 3.0, blurRadius: 5.0, blurStyle: BlurStyle.normal)],
                    color: viewModel.isDarkModeEnabled ? Colors.black : Colors.white
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(viewModel.ingredients[index].recipeIngredient, style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.06), textAlign: TextAlign.center,),
                    const Spacer(),
                  ],
                ),
              );
            },
          )
          ),
        ],
      )
    );
  }

}