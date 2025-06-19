import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobfit/widgets/uncommon/career_dialog.dart';

class SuggestedCareers extends StatelessWidget {
  final String resultType;

  SuggestedCareers({super.key, required this.resultType});

  final Map<String, List<String>> suggestedCareersMap = const {
    'AI Engineer': [
      'Machine Learning Engineer',
      'Data Scientist',
      'AI Researcher',
      'NLP Engineer',
      'Computer Vision Engineer',
    ],
    'Full-Stack Developer': [
      'Frontend Developer',
      'Backend Developer',
      'Web Developer',
      'Software Engineer',
      'API Developer',
    ],
    'Mobile App Developer': [
      'iOS Developer',
      'Android Developer',
      'Flutter Developer',
      'React Native Developer',
      'Mobile UX Designer',
    ],
    'DevOps Engineer': [
      'Cloud Engineer',
      'Site Reliability Engineer',
      'Infrastructure Engineer',
      'Release Manager',
      'Automation Engineer',
    ],
    'Cybersecurity Specialist': [
      'Penetration Tester',
      'Security Analyst',
      'Security Engineer',
      'Incident Responder',
      'Risk Manager',
    ],
  };

  final Map<String, IconData> careerIcons = {
    // AI Engineer careers
    'Machine Learning Engineer': Icons.memory,
    'Data Scientist': Icons.bar_chart,
    'AI Researcher': Icons.psychology,
    'NLP Engineer': Icons.record_voice_over,
    'Computer Vision Engineer': Icons.videocam,

    // Full-Stack Developer careers
    'Frontend Developer': Icons.web,
    'Backend Developer': Icons.storage,
    'Web Developer': Icons.code,
    'Software Engineer': Icons.developer_mode,
    'API Developer': Icons.api,

    // Mobile App Developer careers
    'iOS Developer': Icons.phone_iphone,
    'Android Developer': Icons.android,
    'Flutter Developer': Icons.flutter_dash,
    'React Native Developer': Icons.mobile_friendly,
    'Mobile UX Designer': Icons.design_services,

    // DevOps Engineer careers
    'Cloud Engineer': Icons.cloud,
    'Site Reliability Engineer': Icons.settings,
    'Infrastructure Engineer': Icons.build,
    'Release Manager': Icons.send,
    'Automation Engineer': Icons.autorenew,

    // Cybersecurity Specialist careers
    'Penetration Tester': Icons.security,
    'Security Analyst': Icons.shield,
    'Security Engineer': Icons.phonelink_lock,
    'Incident Responder': Icons.report_problem,
    'Risk Manager': Icons.warning,
  };

  @override
  Widget build(BuildContext context) {
    final careers = suggestedCareersMap[resultType] ?? [];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Icon(Icons.rocket_launch, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 20),
            Text(
              'Top Career Paths for You',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Based on your quiz results, these careers match your strengths!',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 25),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: careers.map((career) {
                final icon = careerIcons[career] ?? Icons.work;

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CareerDialog(career: career, icon: icon),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade500,
                          Colors.purple.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              career,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
