import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:s4k1l/views/base/bug_flying_animation.dart';
import 'package:s4k1l/views/screens/about_me_page.dart';
import 'package:s4k1l/views/screens/projects_page.dart';
import 'hire_me_page.dart';
import '../base/glitch_image.dart';
import '../base/glitch_text.dart';
import '../base/top_bar.dart';
import '../base/bottom_nav.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final pages = [const ProjectsPage(), const AboutMePage(), const HireMePage()];

  double mouseX = 0, mouseY = 0;
  bool get isMouseConnected =>
      RendererBinding.instance.mouseTracker.mouseIsConnected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final isTablet = size.width >= 700 && size.width < 1100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            mouseX = event.position.dx;
            mouseY = event.position.dy;
          });
        },
        child: Stack(
          children: [
            // 🌈 Background gradient reacts to mouse position
            AnimatedContainer(
              duration: const Duration(seconds: 4),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    (mouseX / size.width) * 2 - 1,
                    (mouseY / size.height) * 2 - 1,
                  ),
                  radius: 1.2,
                  colors: const [
                    Color(0xFF001F1F),
                    Color(0xFF010B13),
                    Colors.black,
                  ],
                ),
              ),
            ),

            // 🐞 Floating robot animation
            BugFollowAnimation(
              size: size,
              mouseX: mouseX,
              mouseY: mouseY,
              isMouseConnected: isMouseConnected,
              lottieAsset: 'assets/images/robot.json',
            ),

            // 🌍 Main content
            Column(
              children: [
                TopBar(onIconTap: () {}),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => currentIndex = index),
                    children: [
                      _buildHeroSection(isMobile, isTablet, size),
                      ...pages,
                    ],
                  ),
                ),
                _buildBottomNav(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🧍 Hero Section
  Widget _buildHeroSection(bool isMobile, bool isTablet, Size size) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildHeroContent(isMobile, isTablet),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildHeroContent(isMobile, isTablet),
                ),
        ),
      ),
    );
  }

List<Widget> _buildHeroContent(bool isMobile, bool isTablet) {
  final left = Flexible(
    flex: 5,
    child: Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.green, Colors.greenAccent],
          ).createShader(bounds),
          child: Text(
            "HI, I'M",
            style: TextStyle(
              fontSize: isMobile
                  ? 20
                  : isTablet
                      ? 28
                      : 36,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        GlitchText(
          text: "SHAKIL MAHMUD",
          textStyle: TextStyle(
            fontSize: isMobile
                ? 36
                : isTablet
                    ? 56
                    : 72,
            fontWeight: FontWeight.bold,
          ),
          glitchUpDown: true,
          randomLetterSwitch: true,
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
          ).createShader(bounds),
          child: Text(
            "Flutter Developer | Problem Solver | Tech Enthusiast",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile
                  ? 14
                  : isTablet
                      ? 18
                      : 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildSkillChips(isMobile),
        const SizedBox(height: 32),
        if(!isMobile) Text(
          "I build elegant, high-performance mobile apps that merge creativity and technology.\n"
          "Specialized in Flutter, Firebase, REST APIs, and scalable app architecture.\n"
          "Let’s create something unforgettable — crafted with precision and passion.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile
                ? 13
                : isTablet
                    ? 15
                    : 16,
            height: 1.6,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 32),
        _buildActionButtons(isMobile),
      ],
    ),
  );

  final right = Flexible(
    flex: 4,
    child: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: isMobile
                ? 220
                : isTablet
                    ? 300
                    : 400,
            height: isMobile
                ? 220
                : isTablet
                    ? 300
                    : 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.greenAccent.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          GlitchImage(
            imageProvider: const AssetImage("assets/images/profile.png"),
            maxWidth: isMobile
                ? 200
                : isTablet
                    ? 280
                    : 380,
            maxHeight: isMobile
                ? 200
                : isTablet
                    ? 280
                    : 380,
          ),
        ],
      ),
    ),
  );

  return isMobile
        ? [right, const SizedBox(height: 40), left]
        : [left, const SizedBox(width: 60), right];
}


  Widget _buildSkillChips(bool isMobile) {
    final skills = [
      "Flutter",
      "Dart",
      "Firebase",
      "REST API",
      "GetX",
      "Supabase",
      "Clean Architecture",
      "UI/UX Animation"
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: skills.map((s) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
          ),
          child: Text(
            s,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    final buttons = [
      _glowButton("Projects", Icons.dashboard_outlined, Colors.green, () {
        setState(() => currentIndex = 0);
        _pageController.jumpToPage(1);
      }),
      _glowButton("About Me", Icons.person_outline, Colors.green, () {
        setState(() => currentIndex = 1);
        _pageController.jumpToPage(2);
      }),
      _glowButton("Hire Me", Icons.work_outline, Colors.green, () {
        setState(() => currentIndex = 2);
        _pageController.jumpToPage(3);
      }),
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 10,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: buttons,
    );
  }

  Widget _glowButton(
      String text, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.6), width: 1),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.08),
              Colors.white.withOpacity(0.03),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
          ),
          child: Center(
            child: BottomNav(
              activeIndex: currentIndex,
              onItemTap: (i) {
                setState(() => currentIndex = i);
                _pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut);
              },
            ),
          ),
        ),
      ),
    );
  }
}
