import 'package:flutter/material.dart';
import 'package:smart_cuicine/variables.dart';
import '../../exports.dart';

class Geminiloadingscreen extends StatelessWidget{

  @override
  const Geminiloadingscreen({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context),
      height: getDeviceHeight(context) *  0.475,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.5,
        bottom: getDeviceHeight(context) * 0.025,
      ),
      child: Column(
        children: [
          // Loading Circle
          Container(
            width: getDeviceWidth(context) *  0.45,
            height: getDeviceHeight(context) * 0.2,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.275,
              right: getDeviceWidth(context) * 0.275
            ),
            child : const CircularProgressIndicator(color: Colors.white, strokeWidth: 8.0,)
          ),

          // Loading Message
          Container(
            width: getDeviceWidth(context),
            height: getDeviceHeight(context) * 0.25,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025
            ),
            child: Row(
            children: [
              const Spacer(),
              Text(viewModel.geminiMap.isNotEmpty ? "Ya tenemos tu ${viewModel.geminiMap["Nombre"]}\nGracias por tu paciencia" : "Estamos buscando tu receta\nPor favor, espera un momento", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.045), textAlign: TextAlign.center,),
              const Spacer(),
            ],
    )
          )
        ],
      ),
    );
  }

}