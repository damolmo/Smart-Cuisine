import 'package:flutter/material.dart';
import '../../exports.dart';

class ModesChooser extends StatelessWidget{
  @override
  const ModesChooser({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) *  0.4,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) *  0.05,
        right: getDeviceWidth(context) *  0.05,
        top: getDeviceHeight(context) *  0.4,
        bottom: getDeviceHeight(context) * 0.2
      ),
      child: Column(
        children: [

          // Category
          InkWell(
            onTap: (){
              viewModel.isCategoryDish =  true;
              viewModel.isModeSelected = true;
              viewModel.notifyListeners();
            },
            child : Container(
            width: getDeviceWidth(context) *  0.85,
            height: getDeviceHeight(context) * 0.15,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) *  0.025,
              right: getDeviceWidth(context) * 0.025,
              top: getDeviceHeight(context) *  0.05,
            ),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.8), spreadRadius: 3.0, blurRadius: 10.0, blurStyle: BlurStyle.normal)]
            ),
            child: ListTile(
              leading: Image.asset("assets/icons/option_1.png"),
              title: Text("Sorpréndeme", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) *  0.05, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.white.withOpacity(0.7), offset: Offset.zero, blurRadius: 5.0)]),),
              subtitle: Text("Gemini buscará una receta aleatoria", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.04, shadows: [Shadow(color: Colors.white.withOpacity(0.7), offset: Offset.zero, blurRadius: 4.0)]),),
              trailing: IconButton(
                onPressed : (){
                  viewModel.isCategoryDish =  true;
                  viewModel.isModeSelected = true;
                  viewModel.notifyListeners();
                },

                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 45,),
              ),

            ),
          ),
          ),

          // Free
          Container(
            width: getDeviceWidth(context) *  0.85,
            height: getDeviceHeight(context) * 0.15,
            margin: EdgeInsets.only(
                left: getDeviceWidth(context) *  0.025,
                right: getDeviceWidth(context) * 0.025,
                top: getDeviceHeight(context) *  0.025,
                bottom: getDeviceHeight(context) *  0.025
            ),
            decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), spreadRadius: 3.0, blurRadius: 10.0, blurStyle: BlurStyle.normal)]
            ),
            child: ListTile(
              leading: Image.asset("assets/icons/option_2.png"),
              title: Text("Buscar", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) *  0.05, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.white.withOpacity(0.7), offset: Offset.zero, blurRadius: 5.0)]),),
              subtitle: Text("Gemimi buscará una receta por ti", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.04, shadows: [Shadow(color: Colors.white.withOpacity(0.7), offset: Offset.zero, blurRadius: 4.0)]),),
              trailing: IconButton(
                onPressed : (){
                  viewModel.isCategoryDish =  false;
                  viewModel.isModeSelected = true;
                  viewModel.notifyListeners();
                },

                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 45,),
              ),

            ),
          ),
        ],
      ),
    );
  }

}