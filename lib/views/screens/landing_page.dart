import 'package:flutter/material.dart';
import 'package:s4k1l/views/screens/about_me_page.dart';
import 'package:s4k1l/views/screens/projects_page.dart';
import '../base/background.dart';
import '../base/glitch_image.dart';
import '../base/top_bar.dart';
import '../base/bottom_nav.dart';
import '../base/glitch_text.dart';
import 'experiences_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final pages = [
    ExperiencesPage(),
    ProjectsPage(),
    AboutMePage(),
  ];

  void onNavTap(int index) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundVideo(),
          Column(
            children: [
              const TopBar(),

              // PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) => setState(() => currentIndex = index),
                  children: [
                    // Landing Page Section
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: isMobile
                          ? Column(
                        children: _buildLandingContent(isMobile),
                      )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _buildLandingContent(isMobile),
                      ),
                    ),

                    // Other pages
                    ...pages.map((page) => SizedBox(
                      width: double.infinity,
                      child: page,
                    )),
                  ],
                ),
              ),

              // Bottom Nav
              BottomNav(
                activeIndex: currentIndex,
                onItemTap: onNavTap,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLandingContent(bool isMobile) {
    final left = Container(
      width: isMobile ? double.infinity : null, // full width for mobile
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          GlitchText(
            text: "WELCOME 😈",
            textStyle: TextStyle(fontSize: isMobile ? 16 :  32, fontWeight: FontWeight.bold),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          GlitchText(
            text: "SHAKIL MAHMUD",
            textStyle: TextStyle(fontSize: isMobile ? 30 : 62, fontWeight: FontWeight.bold),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          GlitchText(
            text: "Flutter Developer\nAndroid & iOS App Developer",
            textStyle: TextStyle(fontSize: isMobile ? 24 : 49, fontWeight: FontWeight.w600),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 20),
          GlitchText(
            text:
            "I craft modern, high-performance mobile and web apps using Flutter.\n"
                "Specialized in Firebase, REST APIs, and state management with GetX.\n"
                "Passionate about clean architecture, animations, and delivering seamless user experiences.",
            textStyle: TextStyle(
              fontSize:  16,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
            randomLetterSwitch: true,
            glitchUpDown: true,
          ),
        ],
      ),
    );

    final right = SizedBox(
      width: isMobile ? double.infinity : null, // full width for mobile
      child: Align(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageMaxWidth =
            isMobile ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.5;
            final imageMaxHeight = isMobile ? 300.0 : 500.0;

            return GlitchImage(
              imageProvider: AssetImage("assets/images/profile.png"),
              maxWidth: imageMaxWidth,
              maxHeight: imageMaxHeight,
            );
          },
        ),
      ),
    );

    return isMobile
        ? [left, const SizedBox(height: 20), right]
        : [Expanded(flex: 5, child: left), const SizedBox(width: 20), Expanded(flex: 4, child: right)];
  }

}
