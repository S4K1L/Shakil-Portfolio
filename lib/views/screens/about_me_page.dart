import 'package:flutter/material.dart';
import 'package:s4k1l/data/personal_data.dart';
import 'package:s4k1l/views/base/achievement_widgets.dart';
import 'package:s4k1l/views/base/education_widgets.dart';
import 'package:s4k1l/views/base/experience_section.dart';
import 'package:s4k1l/views/base/skill_widgets.dart';
import '../base/glitch_text.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // skills
    GlobalKey(), // achievements
    GlobalKey(), // education
    GlobalKey(), // work
  ];
  final List<String> _titles = [
    "Skills",
    "Achievements",
    "Education",
    "Work Experience"
  ];

  // computed layout positions (top offsets) of each section in the scrollable area
  final List<double> _sectionOffsets = [0, 0, 0, 0];

  int _activeSection = 0;
  bool _positionsReady = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // compute positions after first layout
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _computeSectionOffsets());
  }

  void _computeSectionOffsets() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final offset = box.localToGlobal(Offset.zero);
          _sectionOffsets[i] = offset.dy + _scrollController.offset;
        }
      }
    }

    setState(() {
      _positionsReady = true;
    });

    _onScroll();
  }

  // reference to the scrollable column's BuildContext ancestor for coordinate conversions
  BuildContext? scrollableColumnContext;

  // helper to compute active section based on scrollController offset and _sectionOffsets
  void _onScroll() {
    if (!_positionsReady) return;

    double viewportCenter = _scrollController.offset +
        (MediaQuery.of(context).size.height - 160) / 2;

    int active = 0;
    for (int i = 0; i < _sectionOffsets.length; i++) {
      final top = _sectionOffsets[i];
      final nextTop = (i + 1 < _sectionOffsets.length)
          ? _sectionOffsets[i + 1]
          : double.infinity;
      if (viewportCenter >= top && viewportCenter < nextTop) {
        active = i;
        break;
      }
    }

    if (active != _activeSection) {
      setState(() {
        _activeSection = active;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll to the section when a left label is tapped
  void _scrollToSection(int idx) {
    if (_sectionKeys[idx].currentContext == null) return;
    Scrollable.ensureVisible(
      _sectionKeys[idx].currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlitchText(
                text: "About Me",
                textStyle: TextStyle(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.bold,
                ),
                randomLetterSwitch: true,
                glitchUpDown: true,
              ),
              // const SizedBox(height: 16),
              // GlitchText(
              //   text: PersonalData().intro,
              //   textStyle: const TextStyle(
              //     fontSize: 16,
              //     color: Colors.white70,
              //     height: 1.5,
              //   ),
              //   randomLetterSwitch: false,
              // ),
              const SizedBox(height: 28),

              // MAIN AREA: for desktop show two columns, for mobile show stacked
              isMobile ? _buildMobileStack() : _buildDesktopTwoColumn(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMobileStack() {
    // On mobile just stack sections (no left label, no right indicator)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlitchText(
          text: "Skills",
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          randomLetterSwitch: true,
        ),
        const SizedBox(height: 12),
        SkillsSection(skills: PersonalData().skills),
        const SizedBox(height: 30),
        GlitchText(
          text: "Achievements",
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          randomLetterSwitch: true,
        ),
        const SizedBox(height: 12),
        AchievementsSection(achievements: PersonalData().achievements),
        const SizedBox(height: 30),
        GlitchText(
          text: "Education",
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          randomLetterSwitch: true,
        ),
        const SizedBox(height: 12),
        EducationSection(education: PersonalData().education),
        const SizedBox(height: 30),
        GlitchText(
          text: "Work Experience",
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          randomLetterSwitch: true,
        ),
        const SizedBox(height: 12),
        WorkExperienceSection(workExperience: PersonalData().workExperience),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildDesktopTwoColumn(BuildContext context) {
    // left column width and right content width
    const leftWidth = 140.0;

    // Outer Row: left labels + right scroll area + small right indicator overlay
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.78,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT LABELS (vertical rotated)
          SizedBox(
            width: leftWidth,
            child: Column(
              children: [
                // vertical divider tick at top to match image style
                const SizedBox(height: 18),
                ...List.generate(_titles.length, (i) {
                  final isActive = i == _activeSection;
                  return GestureDetector(
                    onTap: () => _scrollToSection(i),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 28),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // small colored vertical bar (matches screenshot)
                          Container(
                            width: 6,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isActive ? Colors.green : Colors.white10,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // rotated text
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              _titles[i].toUpperCase(),
                              style: TextStyle(
                                color: isActive ? Colors.green : Colors.white54,
                                fontSize: 14,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(width: 28),

          // RIGHT SCROLLABLE CONTENT (inside a clipped box)
          Expanded(
            child: Stack(
              children: [
                // The primary scrollable column
                NotificationListener<SizeChangedLayoutNotification>(
                  onNotification: (notification) {
                    // recalc offsets when layout changes
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => _computeSectionOffsets());
                    return true;
                  },
                  child: SizeChangedLayoutNotifier(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Builder(builder: (ctx) {
                          // store context reference to use for global coordinate conversion
                          scrollableColumnContext = ctx;
                          // sections with keys
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Skills
                              Container(
                                key: _sectionKeys[0],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlitchText(
                                      text: "Skills",
                                      textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      randomLetterSwitch: true,
                                    ),
                                    const SizedBox(height: 12),
                                    SkillsSection(
                                        skills: PersonalData().skills),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Achievements
                              Container(
                                key: _sectionKeys[1],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlitchText(
                                      text: "Achievements",
                                      textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      randomLetterSwitch: true,
                                    ),
                                    const SizedBox(height: 12),
                                    AchievementsSection(
                                        achievements:
                                            PersonalData().achievements),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Education
                              Container(
                                key: _sectionKeys[2],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlitchText(
                                      text: "Education",
                                      textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      randomLetterSwitch: true,
                                    ),
                                    const SizedBox(height: 12),
                                    EducationSection(
                                        education: PersonalData().education),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Work Experience
                              Container(
                                key: _sectionKeys[3],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlitchText(
                                      text: "Work Experience",
                                      textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      randomLetterSwitch: true,
                                    ),
                                    const SizedBox(height: 12),
                                    WorkExperienceSection(
                                        workExperience:
                                            PersonalData().workExperience),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 60),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
