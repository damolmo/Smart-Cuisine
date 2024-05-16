import 'package:flutter/material.dart';
import 'package:smart_cuicine/LoginScreen/widgets/keyBanner.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class LoginScreenView extends StackedView<LoginScreenModel>{
  @override
  const LoginScreenView({super.key});

  @override
  Widget builder(
      BuildContext context,
      LoginScreenModel viewModel,
      Widget? child
      ){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          // Banner
          if (!viewModel.isUserTyping)
          KeyBanner(viewModel: viewModel),

          // Login Field
          KeyField(viewModel: viewModel),


        ],
      ),
    );
  }

  @override
  LoginScreenModel viewModelBuilder(BuildContext context) => LoginScreenModel(context: context);

}