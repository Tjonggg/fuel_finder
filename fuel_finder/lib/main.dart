import 'package:flutter/material.dart';
import 'package:fuel_finder/di/di.dart';

import 'app.dart';

void main() {
  configureDependencies();

  runApp(const MyApp());
}
