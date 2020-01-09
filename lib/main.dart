import 'package:flutter/material.dart';
import 'package:weather_gci/weatherPage.dart';

void main() { 
  
  ErrorWidget.builder = (FlutterErrorDetails details) => Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
  runApp(WeatherApp());

}


