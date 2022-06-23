import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuel_finder/di/di.dart';
import 'package:fuel_finder/ui/ui.dart';

void main() {
  configureDependencies();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

//This class is a temporary workaround
//For more info check => https://flutteragency.com/solve-flutter-certificate_verify_failed-error-while-performing-a-post-request/
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
