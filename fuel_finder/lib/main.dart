import 'package:flutter/material.dart';
import 'package:fuel_finder/injection.dart';
import 'package:fuel_finder/ui/ui.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
