import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:s4k1l/views/screens/about_me_page.dart';
import 'package:s4k1l/views/screens/projects_page.dart';
import '../base/background.dart';
import '../base/glitch_image.dart';
import '../base/top_bar.dart';
import '../base/bottom_nav.dart';
import '../base/glitch_text.dart';
import 'hire_me_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final pages = [const ProjectsPage(), const AboutMePage(), const HireMePage()];

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
      // extend body behind system bars if you want the video full-bleed
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fullscreen background video
          const Positioned.fill(child: BackgroundVideo()),

          // Semi-transparent dark overlay (keeps TopBar readable)
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.55)),
          ),

          // Foreground content
          Column(
            children: [
              // Top bar sits above the background+overlay
              const TopBar(),

              // PageView (Landing + other pages)
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged:
                      (index) => setState(() => currentIndex = index),
                  children: [
                    // Landing hero section
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: Center(
                          child:
                              isMobile
                                  ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: _buildLandingContent(isMobile),
                                  )
                                  : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildLandingContent(isMobile),
                                  ),
                        ),
                      ),
                    ),

                    // Other pages (already scrollable)
                    ...pages.map(
                      (page) => SizedBox(width: double.infinity, child: page),
                    ),
                  ],
                ),
              ),

              // ---------- Native glass (BackdropFilter) bottom nav ----------
              // We wrap the BottomNav with ClipRRect + BackdropFilter to get glass effect
              // Keeps the BottomNav above the overlay/video and blurred behind it.
              ClipRRect(
                // small radius gives a softened top edge — adjust to taste
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    width: double.infinity,
                    height: 76,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      // subtle gradient + translucency
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.03),
                          Colors.white.withOpacity(0.01),
                        ],
                      ),
                      color: Colors.black.withOpacity(0.35),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                        // faint neon glow
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.06),
                          blurRadius: 24,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: BottomNav(
                        activeIndex: currentIndex,
                        onItemTap: onNavTap,
                      ),
                    ),
                  ),
                ),
              ),
              // ----------------------------------------------------------------
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLandingContent(bool isMobile) {
    final left = SizedBox(
      width: isMobile ? double.infinity : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          GlitchText(
            text: "WELCOME 😈",
            textStyle: TextStyle(
              fontSize: isMobile ? 16 : 32,
              fontWeight: FontWeight.bold,
            ),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          GlitchText(
            text: "SHAKIL MAHMUD",
            textStyle: TextStyle(
              fontSize: isMobile ? 30 : 62,
              fontWeight: FontWeight.bold,
            ),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          GlitchText(
            text: "Flutter Developer\nAndroid & iOS App Developer",
            textStyle: TextStyle(
              fontSize: isMobile ? 24 : 49,
              fontWeight: FontWeight.w600,
            ),
            glitchUpDown: true,
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 20),
          GlitchText(
            text:
                "I craft modern, high-performance mobile and web apps using Flutter.\n"
                "Specialized in Firebase, REST APIs, and state management with GetX.\n"
                "Passionate about clean architecture, animations, and delivering seamless user experiences.",
            textStyle: const TextStyle(
              fontSize: 16,
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
      width: isMobile ? double.infinity : null,
      child: Align(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final imageMaxWidth =
                isMobile
                    ? constraints.maxWidth * 0.8
                    : constraints.maxWidth * 0.5;
            final imageMaxHeight = isMobile ? 300.0 : 500.0;
            return GlitchImage(
              imageProvider: const AssetImage("assets/images/profile.png"),
              maxWidth: imageMaxWidth,
              maxHeight: imageMaxHeight,
            );
          },
        ),
      ),
    );

    return isMobile
        ? [left, const SizedBox(height: 20), right]
        : [
          Expanded(flex: 5, child: left),
          const SizedBox(width: 20),
          Expanded(flex: 4, child: right),
        ];
  }
}
