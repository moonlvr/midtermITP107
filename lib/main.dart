import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leslie Mae Dejayco - Portfolio',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgDark,
        useMaterial3: true,
      ),
      home: const PortfolioScreen(),
    );
  }
}

// Dark brown theme colors
class AppColors {
  static const Color bgDark = Color(0xFF1B0F0A);
  static const Color bgSection = Color(
    0xFF241510,
  ); // slightly lighter section bg
  static const Color cardBrown = Color(0xFF3E2723);
  static const Color cardBrownLight = Color(0xFF4E342E);
  static const Color gold = Color(0xFFD7A86E);
  static const Color coral = Color(0xFFE8785A);
  static const Color cream = Color(0xFFF5E6D3);
  static const Color muted = Color(0xFFB79E8E);
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String _lastAction = 'No gesture yet';
  String _lastOutput = 'Tap, double tap, or long press "Click Me".';

  void _logGesture(String action, String output) {
    print('==============================');
    print('GESTURE EVENT : $action');
    print('OUTPUT        : $output');
    print('==============================');

    setState(() {
      _lastAction = action;
      _lastOutput = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String examDate = '${now.month}/${now.day}/${now.year}';
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 800;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _navBar(isWide),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 48 : 20,
                      vertical: isWide ? 40 : 24,
                    ),
                    child: isWide ? _heroWide(examDate) : _heroNarrow(examDate),
                  ),
                  _skillsSection(isWide),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Top nav bar ----------
  Widget _navBar(bool isWide) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'LD.',
            style: TextStyle(
              color: AppColors.cream,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
          Row(
            children: [
              _navLink('About'),
              const SizedBox(width: 24),
              _navLink('Skills'),
              const SizedBox(width: 24),
              _navLink('Contact'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navLink(String label) {
    return Text(
      label,
      style: const TextStyle(color: AppColors.muted, fontSize: 14),
    );
  }

  // ---------- Hero: wide layout (text left, photo right) ----------
  Widget _heroWide(String examDate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _heroText(examDate)),
        const SizedBox(width: 40),
        Expanded(flex: 4, child: Center(child: _heroPhoto(220))),
      ],
    );
  }

  // ---------- Hero: narrow layout (photo above, text below, centered) ----------
  Widget _heroNarrow(String examDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _heroPhoto(160),
        const SizedBox(height: 24),
        _heroText(examDate, centered: true),
      ],
    );
  }

  Widget _heroPhoto(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.coral, AppColors.cardBrown],
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: Image.asset(
          'assets/profilePic.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.person, size: 64, color: AppColors.cream),
        ),
      ),
    );
  }

  Widget _heroText(String examDate, {bool centered = false}) {
    final crossAlign = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        const Text(
          'Hola!',
          style: TextStyle(
            color: AppColors.coral,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'I am Leslie Mae,\nMobile App Developer',
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColors.cream,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'BSIT student at the University of Cabuyao. I build clean, '
          'functional mobile applications with Flutter and enjoy crafting '
          'thoughtful, well-designed user interfaces.',
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColors.muted,
            height: 1.5,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 14,
          children: [
            GestureDetector(
              onTap: () => _logGesture('Single Tap', 'Exam Date: $examDate'),
              onDoubleTap: () => _logGesture(
                'Double Tap',
                'Professor: Prof. Albert Q. Alforja',
              ),
              onLongPress: () =>
                  _logGesture('Long Press', 'Student Name: Leslie Mae Dejayco'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.coral,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Click Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () =>
                  _logGesture('Button Pressed', 'Contact section opened'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.gold,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: AppColors.gold),
                ),
              ),
              icon: const Icon(Icons.mail_outline, size: 18),
              label: const Text('Contact Me'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _resultChip(),
      ],
    );
  }

  // ---------- On-screen gesture result ----------
  Widget _resultChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBrownLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.terminal, color: AppColors.gold, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: AppColors.cream),
                children: [
                  TextSpan(
                    text: '$_lastAction: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                  TextSpan(text: _lastOutput),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- "Recent posts" style section, repurposed for Skills ----------
  Widget _skillsSection(bool isWide) {
    final skills = [
      {
        'title': 'Flutter Development',
        'tag': 'Mobile, Dart',
        'desc': 'Building cross-platform apps with clean, reusable widgets.',
      },
      {
        'title': 'Kotlin & Android',
        'tag': 'Android, Compose',
        'desc': 'Native Android development using Kotlin and Jetpack Compose.',
      },
      {
        'title': 'UI/UX Design',
        'tag': 'Figma, Wireframes',
        'desc': 'Designing consistent, user-friendly mobile interfaces.',
      },
    ];

    return Container(
      color: AppColors.bgSection,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 20, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'My Skills',
                style: TextStyle(
                  color: AppColors.cream,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View all',
                style: TextStyle(color: AppColors.coral, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          isWide
              ? Row(
                  children: skills
                      .map((s) => Expanded(child: _skillCard(s)))
                      .toList(),
                )
              : Column(children: skills.map((s) => _skillCard(s)).toList()),
        ],
      ),
    );
  }

  Widget _skillCard(Map<String, String> skill) {
    return Card(
      color: AppColors.cardBrown,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill['title']!,
              style: const TextStyle(
                color: AppColors.cream,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.local_offer_outlined,
                  size: 13,
                  color: AppColors.gold,
                ),
                const SizedBox(width: 6),
                Text(
                  skill['tag']!,
                  style: const TextStyle(color: AppColors.gold, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              skill['desc']!,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}