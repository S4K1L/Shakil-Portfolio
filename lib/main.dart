import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s4k1l/utils/theme/theme.dart';
import 'package:s4k1l/views/screens/landing_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shakil Mahmud | Portfolio',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LandingPage()),
        // You can later add:
        // GetPage(name: '/experience', page: () => const ExperiencePage()),
        // GetPage(name: '/projects', page: () => const ProjectsPage()),
        // GetPage(name: '/about', page: () => const AboutPage()),
      ],
    );
  }
}
