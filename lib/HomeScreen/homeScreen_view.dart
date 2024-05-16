import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class HomeScreenView extends StackedView<HomeScreenModel>{
  @override
  const HomeScreenView({
    this.choosedMenuEntry = 0,
    super.key});

  final int choosedMenuEntry;

  @override
  Widget builder(
      BuildContext context,
      HomeScreenModel viewModel,
      Widget? child
      ){

    return PopScope(
      canPop: viewModel.isCategoryDish ?  false : true,
        onPopInvoked: (_){
          viewModel.isCategoryDish = false;
          viewModel.isModeSelected = false;
          viewModel.isGeminiLoading = false;
          viewModel.notifyListeners();
        },
        child : Scaffold(
          resizeToAvoidBottomInset: false,
          body : Stack(
            children: [
              // Background Theme
              BackgroundTheme(viewModel: viewModel,),

              // App Banner
              if (!viewModel.isCategoryDish && viewModel.choosedMenuEntry == 0 || viewModel.isCategoryDish && viewModel.categoryName.isNotEmpty )
              AppBanner(viewModel: viewModel,),

              // Categories LIst
              if (viewModel.isCategoryDish && viewModel.categoryName.isEmpty)
                CategoriesList(viewModel: viewModel),

              // Modes Chooser
              if (!viewModel.isModeSelected && !viewModel.isGeminiLoading && viewModel.choosedMenuEntry == 0)
                ModesChooser(viewModel: viewModel),

              // Recipes List
              if (viewModel.choosedMenuEntry == 1)
                RecipesList(viewModel: viewModel),

              // Custom NavBar
              if (!viewModel.isGeminiLoading)
              CustomNavBar(viewModel: viewModel),


              // Gemini Loading Screen
              if (viewModel.isGeminiLoading)
                Geminiloadingscreen(viewModel: viewModel),

              // User Field
              if (viewModel.isModeSelected && !viewModel.isCategoryDish || viewModel.isModeSelected && viewModel.categoryName.isNotEmpty)
              UserField(viewModel: viewModel),

            ],
          )
        ),
    );
  }

  @override
  HomeScreenModel viewModelBuilder(BuildContext context) => HomeScreenModel(context: context, choosedMenuEntry: choosedMenuEntry);
}