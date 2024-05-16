import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class RecipeScreenView extends StackedView<RecipeScreenModel>{
  @override
  const RecipeScreenView({
    required this.recipeName,
    required this.isDarkModeEnabled,
    super.key
  });

  final bool isDarkModeEnabled;
  final String recipeName;


  @override
  Widget builder(
      BuildContext context,
      RecipeScreenModel viewModel,
      Widget? child
      ){
    return Scaffold(
      body: Stack(
        children: [
          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          if (viewModel.recipes.isNotEmpty && viewModel.ingredients.isNotEmpty && viewModel.instructions.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [

                // Recipe Name Banner
                RecipeNameBanner(viewModel: viewModel),

                // Recipe Ingredients List
                RecipeIngredientsList(viewModel: viewModel),

                // Recipe Steps List
                RecipeStepsList(viewModel: viewModel),
              ],
            ),
          ),

          // Recipe NavBar
          RecipeNavBar(viewModel: viewModel),

        ],
      ),
    );
  }

  @override
  RecipeScreenModel viewModelBuilder(BuildContext context) => RecipeScreenModel(recipeName: recipeName, context: context, isDarkModeEnabled: isDarkModeEnabled);
}