import 'package:flutter/material.dart';
import '../../exports.dart';

class SettingsBanner extends StatelessWidget{
  @override
  SettingsBanner({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) *  0.2,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) *  0.05,
        bottom: getDeviceHeight(context) *  0.75
      ),
      child: Row(
        children: [
          // App Logo Banner
          Container(
            width: getDeviceWidth(context) *  0.25,
            margin: EdgeInsets.only(
              right: getDeviceWidth(context) * 0.05
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/logo/logo.png")
              )
            ),
          ),

          // App Name Banner
          Container(
            width: getDeviceWidth(context) *  0.6,
            child: Text("Smart Cuisine", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) *  0.09, fontWeight: FontWeight.bold),),

          )
        ],
      ),
    );
  }



}