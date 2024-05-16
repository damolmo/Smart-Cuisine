import 'package:flutter/material.dart';
import '../../exports.dart';

class RecipesList extends StatelessWidget{
  @override
  const RecipesList({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.95,
      height: getDeviceHeight(context) * 0.9,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.025,
        right: getDeviceHeight(context) * 0.025,
        top: getDeviceHeight(context) *  0.05,
      ),
      child: Column(
        children: [

          // Recipes Title
          Container(
            width: getDeviceWidth(context) *  0.8,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) *  0.075,
              right: getDeviceWidth(context) * 0.075,
            ),
            decoration: BoxDecoration(
              color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.6) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled?  Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), offset: Offset.zero, blurRadius: 5.0, blurStyle: BlurStyle.normal, spreadRadius: 2.0)],
            ),
            child: Row(
              children: [
                const Spacer(),
                Text("Recetas", style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),
          ),

          // Recipes List
          Container(
            height: getDeviceHeight(context) *  0.75,
            width: getDeviceWidth(context) * 0.9,
            child: ListView.builder(
              itemCount: viewModel.recipes.length,
              itemBuilder: (context, index){
                return Container(
                  width: getDeviceWidth(context) *  0.9,
                  height: getDeviceHeight(context) *  0.12,
                  margin: EdgeInsets.only(
                      bottom: viewModel.recipes.length -1 == index ?  getDeviceHeight(context) * 0.15 : getDeviceHeight(context) *  0.025,
                      left: getDeviceWidth(context) *  0.025,
                      right: getDeviceWidth(context) * 0.025
                  ),
                  decoration: BoxDecoration(
                      color: viewModel.isDarkModeEnabled?  Colors.black.withOpacity(0.8) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)]
                  ),
                  child: ListTile(
                    leading: Icon(Icons.circle, color: viewModel.getRandomColor(), size: 40,),
                    title: Text(viewModel.recipes[index].recipeName, style: TextStyle(color: viewModel.isDarkModeEnabled ?  Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    trailing: IconButton(
                      onPressed : (){
                        // Navigate to the recipe screen!
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecipeScreenView(recipeName: viewModel.recipes[index].recipeName, isDarkModeEnabled: viewModel.isDarkModeEnabled,)));
                      },

                      icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 45, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 5.0)],),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }

}