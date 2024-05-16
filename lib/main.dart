import 'dart:io';

import 'package:flutter/material.dart';
import 'exports.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  // Gemini API initialization
  // Get things ready before launching Material App
  runApp(const SmartCuicineApp());
}

class SmartCuicineApp extends StatelessWidget{
  @override
  const SmartCuicineApp({
    super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: LoginScreenView() ,
      routes : {
        "home" : (_) => HomeScreenView(),
      }
    );
  }
}