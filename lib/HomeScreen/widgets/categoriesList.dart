import 'package:flutter/material.dart';
import '../../exports.dart';

class CategoriesList extends StatelessWidget{
  @override
  const CategoriesList({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.95,
      height: getDeviceHeight(context) *  0.8,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) *  0.05,
        bottom: getDeviceHeight(context) *  0.15,
        left: getDeviceWidth(context) * 0.025,
        right: getDeviceWidth(context) *  0.025
      ),
      child: ListView.builder(
          itemCount: viewModel.categories.length,
          itemBuilder: (context, index){
            return Container(
              width: getDeviceWidth(context) *  0.85,
              height: getDeviceHeight(context) *  0.4,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) *  0.05,
                right: getDeviceWidth(context) * 0.05,
              ),
              child: Stack(
                children: [

                  // Text Footer
                  Container(
                    height: getDeviceHeight(context) *  0.15,
                    margin: EdgeInsets.only(
                      top: getDeviceHeight(context) *  0.17,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        Container(width: getDeviceWidth(context) *  0.025),
                        Text(viewModel.categories[index].categoryName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) *  0.09),),
                        const Spacer(),
                        IconButton(
                            onPressed: (){
                              viewModel.categoryName =  viewModel.categories[index].categoryName;
                              viewModel.isDishField = false;
                              viewModel.notifyListeners();
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 50, shadows: [Shadow(color: Colors.black, offset: Offset.zero, blurRadius: 10.0)],))
                      ],
                    ),
                  ),


                  // Image Banner
                  Container(
                    height: getDeviceHeight(context) *  0.2,
                    margin: EdgeInsets.only(
                      bottom: getDeviceHeight(context) *  0.15
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)],
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(viewModel.categories[index].categoryImage)
                      )
                    ),
                  ),
                ],
              ),
            );
          },
      )
    );
  }
}