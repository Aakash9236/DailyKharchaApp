import 'package:daily_expenses/services/storage_services.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Services
  await StorageService.init();

  runApp(
    const ExpenseManagerApp(),
  );
}