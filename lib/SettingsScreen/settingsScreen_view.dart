import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class SettingsScreenView extends StackedView<SettingsScreenModel>{
  @override
  const SettingsScreenView({
    required this.isDarkModeEnabled,
    super.key});

  final bool isDarkModeEnabled;

  @override
  Widget builder(
      BuildContext context,
      SettingsScreenModel viewModel,
      Widget? child
      ){
    return PopScope(
      canPop: viewModel.choosedSettingOption == 0 || viewModel.choosedSettingOption == 1 || viewModel.choosedSettingOption == 2 ? false : true,
        onPopInvoked: (_){
          viewModel.choosedSettingOption = 99;
          viewModel.notifyListeners();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body : Stack(
            children :[

              // Background Theme
              BackgroundTheme(viewModel: viewModel),

              // Banner
              SettingsBanner(viewModel: viewModel),

              // Settings List
              SettingsList(viewModel: viewModel),

              // NavBar
              CustomNavBar(viewModel: viewModel),

              // Theme Selector
              if (viewModel.choosedSettingOption == 0)
                SettingsThemeSelector(viewModel: viewModel),

              // key Field
              if (viewModel.choosedSettingOption == 2)
                InsertKeyField(viewModel: viewModel),

            ]
          )
        ),
    );
  }

  @override
  SettingsScreenModel viewModelBuilder(BuildContext context) => SettingsScreenModel(context: context, isDarkModeEnabled: isDarkModeEnabled);


}