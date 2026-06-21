import 'package:flutter/material.dart';

import 'home.dart';
import 'widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppTheme.background,

      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              const Text(
                "Welcome to SpaceNews Core Application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              Image.network(
                "https://images.unsplash.com/photo-1495020689067-958852a7765e",
                height: 250,
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: "Continue",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}