import 'package:flutter/material.dart';
import 'package:modulo_a2_v1/appController.dart';
import 'package:modulo_a2_v1/services/apiService.dart';
import 'package:modulo_a2_v1/services/mock_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   final prefs = await SharedPreferences.getInstance();
   await prefs.clear();

  final api = MockApiService();

  runApp(AppController(api: api));
}
