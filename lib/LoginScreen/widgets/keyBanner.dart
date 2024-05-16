import 'package:flutter/material.dart';
import '../../exports.dart';

class KeyBanner extends StatelessWidget{
  @override
  KeyBanner({
    required this.viewModel,
    super.key
});

  final LoginScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.8,
      height: getDeviceHeight(context) *  0.7,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context) * 0.1,
        top: getDeviceHeight(context) * 0.1,
        bottom: getDeviceHeight(context) * 0.2
      ),
      child: Column(
        children: [
          // Banner Image
          Container(
            width: getDeviceWidth(context) * 0.5,
            height: getDeviceHeight(context) *  0.25,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.15,
              right: getDeviceWidth(context) * 0.15,
            ),
            child: Column(
              children: [
                Container(
                  width: getDeviceWidth(context) * 0.5,
                  height: getDeviceHeight(context) *  0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/logo/logo.png")
                    )
                  ),
                ),

                Container(
                  height: getDeviceHeight(context) * 0.06,
                  child:Text("Welcome", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.1),),
                ),
              ],
            )
          ),

          // Banner Text

          Container(
            width: getDeviceWidth(context) *  0.8,
            height: getDeviceHeight(context) * 0.35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 2.0)]
            ),
            child:  Container(
                width: getDeviceWidth(context) *  0.75,
                height: getDeviceHeight(context) *  0.35,
                margin: EdgeInsets.only(
                  left: getDeviceWidth(context) * 0.025,
                  right: getDeviceWidth(context) * 0.025,
                  top: getDeviceHeight(context) * 0.025,
                  bottom: getDeviceHeight(context) * 0.025
                ),
                child: SingleChildScrollView(
                  child: Text("Para usar 'Smart Cuisine' en tu dispositivo,es necesario introducir una clave.\n\nContacta con el desarrollador de la aplicación para obtenerla.\nEsta comprobación nos ayuda a que esta aplicación siga funcionando.Gracias", style: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),

              )
            ),
          ),
        ],
      ),
    );
  }

}