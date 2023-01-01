import 'package:flutter/material.dart';
import 'package:shopping_app/app/di.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp(MyApp());
}

