import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerDialog extends StatelessWidget {
  final String career;
  final IconData icon;

  const CareerDialog({super.key, required this.career, required this.icon});

  // Normalize title by removing emojis, punctuation, etc.
  String normalizeTitle(String title) {
    return title.replaceAll(RegExp(r'[^\w\s]'), '').trim().toLowerCase();
  }

  // Full career data
  static const Map<String, Map<String, dynamic>> careerDetails = {
    'Machine Learning Engineer': {
      'skills': [
        'Python',
        'TensorFlow',
        'PyTorch',
        'Data Preprocessing',
        'Model Deployment',
      ],
      'salary': '\$100,000 - \$160,000',
    },
    'Data Scientist': {
      'skills': [
        'Python',
        'Statistics',
        'Pandas',
        'Scikit-learn',
        'Data Visualization',
      ],
      'salary': '\$90,000 - \$150,000',
    },
    'AI Researcher': {
      'skills': [
        'Deep Learning',
        'Mathematical Modeling',
        'Research Papers',
        'PyTorch',
        'NLP',
      ],
      'salary': '\$110,000 - \$170,000',
    },
    'NLP Engineer': {
      'skills': [
        'Text Processing',
        'BERT/GPT',
        'SpaCy',
        'Transformers',
        'Linguistics',
      ],
      'salary': '\$95,000 - \$155,000',
    },
    'Computer Vision Engineer': {
      'skills': ['OpenCV', 'YOLO', 'Image Processing', 'CNNs', 'Deep Learning'],
      'salary': '\$100,000 - \$160,000',
    },

    // Full-stack Developer Roles
    'Frontend Developer': {
      'skills': ['HTML', 'CSS', 'JavaScript', 'React', 'Responsive Design'],
      'salary': '\$70,000 - \$120,000',
    },
    'Backend Developer': {
      'skills': [
        'Node.js',
        'Express.js',
        'Databases',
        'API Development',
        'Authentication',
      ],
      'salary': '\$75,000 - \$130,000',
    },
    'Web Developer': {
      'skills': ['HTML', 'CSS', 'JavaScript', 'Responsive Design', 'SEO'],
      'salary': '\$60,000 - \$110,000',
    },
    'Software Engineer': {
      'skills': [
        'System Design',
        'OOP',
        'Version Control',
        'Databases',
        'Debugging',
      ],
      'salary': '\$80,000 - \$140,000',
    },
    'API Developer': {
      'skills': [
        'REST APIs',
        'JSON',
        'Authentication',
        'Rate Limiting',
        'Documentation',
      ],
      'salary': '\$75,000 - \$125,000',
    },

    // Mobile App Developer Roles
    'iOS Developer': {
      'skills': ['Swift', 'UIKit', 'Xcode', 'MVVM', 'App Store Guidelines'],
      'salary': '\$80,000 - \$130,000',
    },
    'Android Developer': {
      'skills': [
        'Kotlin',
        'Android Studio',
        'Jetpack',
        'Room DB',
        'Material Design',
      ],
      'salary': '\$75,000 - \$125,000',
    },
    'Flutter Developer': {
      'skills': [
        'Dart',
        'Flutter Widgets',
        'State Management',
        'Firebase',
        'REST APIs',
      ],
      'salary': '\$70,000 - \$120,000',
    },
    'React Native Developer': {
      'skills': [
        'JavaScript',
        'React Native',
        'Navigation',
        'Redux',
        'Cross-platform Debugging',
      ],
      'salary': '\$70,000 - \$115,000',
    },
    'Mobile UX Designer': {
      'skills': [
        'Figma',
        'User Research',
        'Prototyping',
        'Accessibility',
        'Design Systems',
      ],
      'salary': '\$65,000 - \$110,000',
    },

    // DevOps Roles
    'Cloud Engineer': {
      'skills': [
        'AWS/GCP/Azure',
        'Linux',
        'Terraform',
        'Monitoring',
        'Security',
      ],
      'salary': '\$85,000 - \$140,000',
    },
    'Site Reliability Engineer': {
      'skills': [
        'SRE Principles',
        'SLAs/SLIs/SLOs',
        'Monitoring Tools',
        'Kubernetes',
        'Incident Management',
      ],
      'salary': '\$90,000 - \$150,000',
    },
    'Infrastructure Engineer': {
      'skills': [
        'Infrastructure as Code',
        'Networking',
        'Terraform',
        'Ansible',
        'Security',
      ],
      'salary': '\$85,000 - \$140,000',
    },
    'Release Manager': {
      'skills': [
        'CI/CD',
        'Version Control',
        'Release Planning',
        'Automation',
        'Rollback Strategies',
      ],
      'salary': '\$80,000 - \$130,000',
    },
    'Automation Engineer': {
      'skills': [
        'Scripting (Python/Bash)',
        'CI/CD',
        'Test Automation',
        'Monitoring',
        'Docker',
      ],
      'salary': '\$75,000 - \$125,000',
    },

    // Cybersecurity Roles
    'Penetration Tester': {
      'skills': [
        'Kali Linux',
        'Burp Suite',
        'OWASP Top 10',
        'Network Scanning',
        'Social Engineering',
      ],
      'salary': '\$80,000 - \$140,000',
    },
    'Security Analyst': {
      'skills': [
        'SIEM',
        'Log Analysis',
        'Threat Detection',
        'Incident Response',
        'Firewall Config',
      ],
      'salary': '\$75,000 - \$130,000',
    },
    'Security Engineer': {
      'skills': [
        'Security Architecture',
        'Encryption',
        'Vulnerability Scanning',
        'IDS/IPS',
        'Compliance',
      ],
      'salary': '\$85,000 - \$140,000',
    },
    'Incident Responder': {
      'skills': [
        'Threat Hunting',
        'Digital Forensics',
        'SIEM Tools',
        'Response Playbooks',
        'Malware Analysis',
      ],
      'salary': '\$80,000 - \$135,000',
    },
    'Risk Manager': {
      'skills': [
        'Risk Assessment',
        'Governance',
        'Compliance Standards',
        'Policy Creation',
        'Audit Readiness',
      ],
      'salary': '\$85,000 - \$140,000',
    },
  };

  Map<String, dynamic> getCareerInfo(String title) {
    final normalized = normalizeTitle(title);
    return careerDetails.entries
        .firstWhere(
          (e) => normalizeTitle(e.key) == normalized,
          orElse: () => MapEntry('Unknown', {
            'skills': ['Problem Solving', 'Communication'],
            'salary': 'Depends on region & experience',
          }),
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final info = getCareerInfo(career);
    final skills = info['skills'] as List<String>;
    final salary = info['salary'] as String;

    return AlertDialog(
      backgroundColor: Colors.deepPurple.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
      title: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              career,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Required Skills:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple.shade400,
                ),
              ),
              const SizedBox(height: 6),
              ...skills.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('• $s', style: GoogleFonts.poppins(fontSize: 14)),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Estimated Salary:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple.shade400,
                ),
              ),
              Text(salary, style: GoogleFonts.poppins(fontSize: 14)),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // Optional: Add learn more logic here
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          child: const Text('Learn More'),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CareerDialog extends StatelessWidget {
//   final String career;
//   final IconData icon;

//   const CareerDialog({super.key, required this.career, required this.icon});

//   // Remove emojis and normalize the title
//   String normalizeTitle(String title) {
//     // Removes non-letter characters (emojis, symbols)
//     return title.replaceAll(RegExp(r'[^\w\s]'), '').trim().toLowerCase();
//   }

//   Map<String, dynamic> getCareerInfo(String title) {
//     const data = {
//       'AI Engineer': {
//         'skills': [
//           'Python',
//           'TensorFlow',
//           'PyTorch',
//           'Data Analysis',
//           'Statistics',
//           'Deep Learning',
//           'Natural Language Processing',
//           'Model Deployment',
//           'Big Data Tools (Hadoop, Spark)',
//           'Cloud Platforms (AWS, GCP, Azure)',
//         ],
//         'salary': '\$90,000 - \$160,000',
//       },
//       'Full-Stack Developer': {
//         'skills': [
//           'JavaScript',
//           'React',
//           'Node.js',
//           'Express.js',
//           'HTML/CSS',
//           'Databases (SQL/NoSQL)',
//           'RESTful APIs',
//           'Version Control (Git)',
//           'Docker',
//           'CI/CD Pipelines',
//         ],
//         'salary': '\$70,000 - \$140,000',
//       },
//       'Mobile App Developer': {
//         'skills': [
//           'Flutter',
//           'Kotlin',
//           'Swift',
//           'Java',
//           'REST APIs',
//           'UI/UX Principles',
//           'Firebase',
//           'App Store Deployment',
//           'Git',
//           'Unit Testing',
//         ],
//         'salary': '\$60,000 - \$120,000',
//       },
//       'DevOps Engineer': {
//         'skills': [
//           'Linux/Unix',
//           'Docker',
//           'Kubernetes',
//           'CI/CD',
//           'Infrastructure as Code (Terraform, Ansible)',
//           'Cloud Platforms (AWS, Azure, GCP)',
//           'Monitoring & Logging',
//           'Scripting (Python, Bash)',
//           'Networking',
//           'Security Best Practices',
//         ],
//         'salary': '\$80,000 - \$150,000',
//       },
//       'Cybersecurity Specialist': {
//         'skills': [
//           'Network Security',
//           'Penetration Testing',
//           'Ethical Hacking',
//           'Cryptography',
//           'Security Information and Event Management (SIEM)',
//           'Firewalls & VPNs',
//           'Incident Response',
//           'Risk Assessment',
//           'Compliance Standards (ISO, GDPR, HIPAA)',
//           'Programming (Python, PowerShell)',
//         ],
//         'salary': '\$75,000 - \$140,000',
//       },
//     };

//     final normalizedInput = normalizeTitle(title);
//     print('Career input: "$title" normalized as: "$normalizedInput"');

//     final entry = data.entries.firstWhere(
//       (e) {
//         final keyNormalized = normalizeTitle(e.key);
//         print('Comparing to: "$keyNormalized"');
//         return keyNormalized == normalizedInput;
//       },
//       orElse: () {
//         print('No match found for "$normalizedInput"');
//         return MapEntry('unknown', {
//           'skills': ['Problem Solving', 'Collaboration'],
//           'salary': 'Varies by role & region',
//         });
//       },
//     );

//     return entry.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final info = getCareerInfo(career);
//     final skills = info['skills'] as List<String>;
//     final salary = info['salary'] as String;

//     return AlertDialog(
//       backgroundColor: Colors.deepPurple.shade50,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       titlePadding: const EdgeInsets.all(20),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
//       title: Row(
//         children: [
//           Icon(icon, color: Colors.deepPurple, size: 28),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               career,
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//           ),
//         ],
//       ),
//       content: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.6,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Required Skills:',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.deepPurple.shade400,
//               ),
//             ),
//             const SizedBox(height: 6),
//             ...skills.map(
//               (s) => Padding(
//                 padding: const EdgeInsets.only(bottom: 4.0),
//                 child: Text('• $s', style: GoogleFonts.poppins(fontSize: 14)),
//               ),
//             ),
//             const SizedBox(height: 14),
//             Text(
//               'Estimated Salary:',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.deepPurple.shade400,
//               ),
//             ),
//             Text(salary, style: GoogleFonts.poppins(fontSize: 14)),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.deepPurple,
//             textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//           ),
//           child: const Text('Close'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             // Add your 'Learn More' action here, e.g., launch URL
//           },
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.deepPurple,
//             textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//           ),
//           child: const Text('Learn More'),
//         ),
//       ],
//     );
//   }
// }
