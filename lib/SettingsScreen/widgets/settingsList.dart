import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../exports.dart';

class SettingsList extends StatelessWidget{
  @override
  const SettingsList({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.95,
      height: getDeviceHeight(context) * 0.6,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.25,
        bottom: getDeviceHeight(context) * 0.15,
        left: getDeviceWidth(context) * 0.025,
        right: getDeviceWidth(context) * 0.025
      ),
      child: ListView.builder(
        itemCount: viewModel.settings.length,
        itemBuilder: (context, index){
          return Container(
            width: getDeviceWidth(context) *  0.9,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) *  0.05,
              right: getDeviceWidth(context) * 0.05,
              bottom: getDeviceHeight(context) *  0.025
              ),
            decoration: BoxDecoration(
              color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.8) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
            ),
            child: ListTile(
              leading: Icon(IconData(viewModel.settings[index].settingIcon, fontFamily: 'MaterialIcons'), size: 40, color: viewModel.isDarkModeEnabled? Colors.white : Colors.black,),
              title: Text(viewModel.settings[index].settingName, style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05), textAlign: TextAlign.left,),
              subtitle: Text(viewModel.settings[index].settingDescription, style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold),),
              trailing: IconButton(
                onPressed : () {
                  if (viewModel.settings[index].settingName == "Modo Oscuro") {
                    viewModel.choosedSettingOption = 0;
                    viewModel.notifyListeners();
                  } else
                  if (viewModel.settings[index].settingName == "Borrar datos") {
                    viewModel.choosedSettingOption = 1;
                    viewModel.dropAllData();
                    viewModel.notifyListeners();
                  } else if (viewModel.settings[index].settingName == "Gemini API Key") {
                    viewModel.choosedSettingOption = 2;
                    viewModel.notifyListeners();

                  } else {
                    launchUrlString("https://github.com/damolmo/Smart-Cuisine");

                  }
                },

                icon: Icon(Icons.arrow_forward_ios_rounded, color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, size: 40, shadows: [Shadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), offset: Offset.zero, blurRadius: 5.0)],),
              ),
            ),
          );
          },
      )
    );
  }

}