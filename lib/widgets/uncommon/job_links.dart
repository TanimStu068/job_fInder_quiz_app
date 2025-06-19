import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String normalize(String input) {
  return input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
}

class JobLinks extends StatelessWidget {
  final String type;

  JobLinks({super.key, required this.type});

  final Map<String, String> typeUrls = {
    'AI Engineer': 'https://machinelearningnow.com/',
    'Full-Stack Developer':
        'https://www.programmingjobboard.com/categories/devops',
    'Mobile App Developer': 'https://stackoverflow.com/jobs',
    'DevOps Engineer': 'https://devopsjobs.io/',
    'Cybersecurity Specialist': 'https://infosecjobboard.com/',
  };

  final Map<String, IconData> platformIcons = {
    'Glassdoor': FontAwesomeIcons.building,
    'LinkedIn': FontAwesomeIcons.linkedin,
  };

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple.shade400,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: GoogleFonts.poppins(fontSize: 16),
  );

  void _launchURL(BuildContext context, String url) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening job link...')));

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = typeUrls[type];

    if (url == null) {
      return Text(
        'No job links available for "$type".',
        style: GoogleFonts.poppins(color: Colors.redAccent),
      );
    }

    final String slug = normalize(type);

    final List<Map<String, String>> extraLinks = [
      {
        'title': 'Glassdoor',
        'url': 'https://www.glassdoor.com/Job/$slug-jobs-SRCH_KO0,12.htm',
      },
      {'title': 'LinkedIn', 'url': 'https://www.linkedin.com/jobs/$slug-jobs'},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Center(
              child: Icon(
                Icons.work_outline, // or FontAwesomeIcons.briefcase
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Explore $type Jobs',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 239, 241),
              ),
            ),
            const SizedBox(height: 8),
            // MAIN button (e.g., StackOverflow, Behance)
            GestureDetector(
              onTap: url == null ? null : () => _launchURL(context, url),
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.open_in_new,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Learn More',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 17),
            ...extraLinks.map(
              (link) => GestureDetector(
                onTap: () => _launchURL(context, link['url']!),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade400,
                        Colors.deepPurple.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        platformIcons[link['title']] ?? Icons.launch,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'View on ${link['title']}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
