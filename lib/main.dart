import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'splash.dart';
import 'widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SpaceNewsCore());
}

class SpaceNewsCore extends StatelessWidget {
  const SpaceNewsCore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpaceNews Core',
      theme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor:
            AppTheme.background,

        primaryColor:
            AppTheme.primary,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.card,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        cardColor: AppTheme.card,

        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(
          backgroundColor:
              AppTheme.card,

          selectedItemColor:
              AppTheme.primary,

          unselectedItemColor:
              Colors.grey,
        ),
      ),
      home: const SplashPage(),
    );
  }
}