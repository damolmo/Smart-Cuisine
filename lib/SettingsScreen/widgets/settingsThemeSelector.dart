import 'package:flutter/material.dart';
import '../../exports.dart';

class SettingsThemeSelector extends StatelessWidget{
  @override
  SettingsThemeSelector({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.7,
      height: getDeviceHeight(context) * 0.5,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.15,
        right: getDeviceWidth(context) * 0.15,
        top: getDeviceHeight(context) * 0.25,
        bottom: getDeviceHeight(context) * 0.25
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled? Colors.black.withOpacity(0.8) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 5.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
      ),
      child: Column(
        children: [
          // Theme Banner
          Container(
            height: getDeviceHeight(context) *  0.15,
            width: getDeviceWidth(context) *  0.5,
            margin: EdgeInsets.only(
              bottom: getDeviceHeight(context) * 0.025,
              left: getDeviceWidth(context) * 0.1,
              right: getDeviceWidth(context) * 0.1
            ),
            child: Row(
              children: [
                // Themes Icon
                Container(
                  width: getDeviceWidth(context) * 0.15,
                  child: Icon(Icons.palette_rounded, color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, size: 40, shadows: [Shadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6))],),
                ),

                // Theme Text
                Container(
                  width: getDeviceWidth(context) *  0.3,
                  child: Text("Temas", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.06, fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),

          // First Color
          InkWell(
            onTap: (){
              viewModel.changeCurrentSettings("false");
              viewModel.choosedSettingOption = 99;
              viewModel.notifyListeners();
            },
            child : Container(
              height: getDeviceHeight(context) *  0.12,
              width: getDeviceWidth(context) *  0.7,
              margin: EdgeInsets.only(
                bottom: getDeviceHeight(context) * 0.025,
                left: getDeviceWidth(context) * 0.1,
                right: getDeviceWidth(context) * 0.1
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: viewModel.isDarkModeEnabled? Colors.black.withOpacity(0.8) : Colors.white,
                  boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 4.0, blurStyle: BlurStyle.normal, spreadRadius: 2.0)]
              ),
              child: Row(
                children: [
                  // Color Icon
                  Container(
                    width: getDeviceWidth(context) *  0.09,
                    height: getDeviceHeight(context) * 0.05,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.05,
                      left: getDeviceWidth(context) *  0.025,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 5.0, spreadRadius: 3.0)],
                    ),
                  ),

                  // Color Name
                  Container(
                    width: getDeviceWidth(context) * 0.3,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.025,
                      bottom: getDeviceHeight(context) * 0.025
                    ),
                    child: Text("Claro", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.04),),

                  )
                ],
              ),
            ),
          ),

          // Second Color
          InkWell(
            onTap: (){
              viewModel.changeCurrentSettings("true");
              viewModel.choosedSettingOption = 99;
              viewModel.notifyListeners();
            },
            child : Container(
              height: getDeviceHeight(context) *  0.12,
              width: getDeviceWidth(context) *  0.7,
              margin: EdgeInsets.only(
                  bottom: getDeviceHeight(context) * 0.025,
                  left: getDeviceWidth(context) * 0.1,
                  right: getDeviceWidth(context) * 0.1
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: viewModel.isDarkModeEnabled? Colors.black.withOpacity(0.8) : Colors.white,
                  boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 4.0, blurStyle: BlurStyle.normal, spreadRadius: 2.0)]
              ),
              child: Row(
                children: [
                  // Color Icon
                  Container(
                    width: getDeviceWidth(context) *  0.09,
                    height: getDeviceHeight(context) * 0.05,
                    margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.05,
                      left: getDeviceWidth(context) *  0.025,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 5.0, spreadRadius: 3.0)],
                    ),
                  ),

                  // Color Name
                  Container(
                    width: getDeviceWidth(context) * 0.3,
                    margin: EdgeInsets.only(
                        right: getDeviceWidth(context) * 0.025,
                        bottom: getDeviceHeight(context) * 0.025
                    ),
                    child: Text("Oscuro", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.04),),

                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}