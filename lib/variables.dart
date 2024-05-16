// Public variables to be available across all app
import 'package:flutter/material.dart';

Color backgroundColor = Color(int.parse("FFff9f00", radix: 16));
double getDeviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getDeviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
String geminiApi = "";
