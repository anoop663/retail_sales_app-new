import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    Future.delayed(const Duration(seconds: 2), () {
     // var categories;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFF6968), 
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(), 
              ),
              Image.asset(
                'lib/assets/app_icon.png',
                width: 150, 
                height: 150, 
              ),
              const SizedBox(height: 16), 
              const Text(
                'Retailer Helper App', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                child: SizedBox(), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
