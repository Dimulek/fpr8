import 'package:flutter/material.dart';
import 'package:fpr8/di/service.dart';
import 'package:fpr8/features/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const App());
}
