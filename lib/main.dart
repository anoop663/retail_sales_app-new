import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:project_fourth/db/models/data_model.dart';
import 'package:project_fourth/screen_splash.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
    Hive.registerAdapter(RetailModel2Adapter());
    Hive.registerAdapter(CategoryModelAdapter());
     Hive.registerAdapter(ProductModelAdapter());
      Hive.registerAdapter(CustomerModelAdapter());
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: const TextTheme(
        // Define the default text styles using Montserrat font
        bodySmall: TextStyle(fontFamily: 'Montserrat'),
        bodyLarge: TextStyle(fontFamily: 'Montserrat'),
        bodyMedium: TextStyle(fontFamily: 'Montserrat'),
        // Add more text styles as needed
      ),
    ),
    home: const SplashScreen(),
  ));
}