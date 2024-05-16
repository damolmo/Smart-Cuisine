import 'package:flutter/material.dart';
import '../../exports.dart';
import '../../variables.dart';

class AppBanner extends StatelessWidget{
  @override
  const AppBanner({
    required this.viewModel,
    super.key});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.9,
      height: getDeviceHeight(context) *  0.35,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.1,
        bottom: getDeviceHeight(context) * 0.55
      ),
      child: Column(
        children: [
          // Image Banner
          Container(
            height: getDeviceHeight(context) *  0.25,
            width: getDeviceWidth(context) *  0.4,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.25,
              right: getDeviceWidth(context) * 0.25,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/logo/logo.png")
              )
            ),
          ),

          // Text Banner
          Container(
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.025,
              right: getDeviceWidth(context) * 0.025
            ),
            child: Row(
              children: [
                const Spacer(),
                Text(!viewModel.isModeSelected ? "¿Que preparamos hoy?" :  viewModel.isDishField ? "¿Qué te apetece comer hoy?" : "¿Cuántos comensales son?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.065, shadows: const [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 5.0)]), textAlign: TextAlign.center,),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}