import 'package:flutter/material.dart';
import '../exports.dart';

class CustomNavBar extends StatelessWidget{
  @override
  const CustomNavBar({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) *  0.12,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) *  0.85,
        bottom: getDeviceHeight(context) * 0.03
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.8) : Colors.purple.withOpacity(0.45),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.7), blurRadius: 14.0, spreadRadius: 2.0, blurStyle: BlurStyle.normal)]
      ),
      child: Row(
        children: [
          // IA Button
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: viewModel.choosedMenuEntry == 0 ? getDeviceHeight(context) *  0.12 :  getDeviceHeight(context) *  0.08,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) *  0.025,
              right: getDeviceWidth(context) * 0.05
            ),
            child: Column(
              children: [

                IconButton(
                  onPressed : (){
                    viewModel.choosedMenuEntry = 0;
                    viewModel.notifyListeners();
                    Navigator.of(context).pushNamed("home");
                  },

                  icon: Icon(Icons.chat_bubble_rounded, color: viewModel.choosedMenuEntry == 0? Colors.white :Colors.blueAccent, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: viewModel.choosedMenuEntry == 0 ? 12.0 : 10.0)], size: 40,),
                ),

                // Icon Name
                if (viewModel.choosedMenuEntry == 0)
                  Container(
                    height: getDeviceHeight(context) *  0.04,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text("Asistente", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.05, shadows: const [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 5.0)]),),
                        const Spacer(),
                      ],
                    ),
                  )
              ],
            )
          ),

          // Categories Button
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: viewModel.choosedMenuEntry == 1 ? getDeviceHeight(context) *  0.12 : getDeviceHeight(context) * 0.08,
            margin: EdgeInsets.only(
                right: getDeviceWidth(context) * 0.05
            ),
            child: Column(
              children: [
                // Icon
                IconButton(
                  onPressed : (){
                    viewModel.choosedMenuEntry = 1;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreenView(choosedMenuEntry: 1,)));
                    viewModel.notifyListeners();

                  },

                  icon: Icon(Icons.book_rounded, color: viewModel.choosedMenuEntry == 1? Colors.white :Colors.orange, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius:viewModel.choosedMenuEntry == 1 ? 12.0 : 10.0)], size: 40,),
                ),

                // Icon Name
                if (viewModel.choosedMenuEntry == 1)
                Container(
                  height: getDeviceHeight(context) *  0.04,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text("Recetario", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.05, shadows: const [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 5.0)]),),
                      const Spacer(),
                    ],
                  ),
                )

              ],
             )
          ),

          // Settings Button
          Container(
            width: getDeviceWidth(context) *  0.25,
            height: viewModel.choosedMenuEntry == 2 ? getDeviceHeight(context) *  0.12 : getDeviceHeight(context) * 0.08,
            margin: EdgeInsets.only(
                right: getDeviceWidth(context) * 0.025
            ),
            child: Column(
              children: [

                IconButton(
                onPressed : (){
                viewModel.choosedMenuEntry = 2;
                viewModel.notifyListeners();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreenView(isDarkModeEnabled: viewModel.isDarkModeEnabled)));
                },

                icon: Icon(Icons.settings_rounded, color: viewModel.choosedMenuEntry == 2? Colors.white :Colors.green, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: viewModel.choosedMenuEntry == 2 ? 12.0 :10.0)], size: 40,),
                ),

                if (viewModel.choosedMenuEntry == 2)
                  Container(
                    height: getDeviceHeight(context) *  0.04,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text("Ajustes", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.05, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 5.0)]),),
                        const Spacer(),
                      ],
                    ),
                  )
              ],
            )
          ),
        ],
      ),
    );
  }
}