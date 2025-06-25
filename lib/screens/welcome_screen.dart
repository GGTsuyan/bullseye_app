import 'package:flutter/material.dart';
import '../theme/theme_constants.dart';
import 'get_started_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome to BullsEye!',
                      textAlign: TextAlign.center,
                      style: ThemeConstants.headingLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Automatically track and score your dart throws with just your phone.',
                      textAlign: TextAlign.center,
                      style: ThemeConstants.bodyText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/target.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GetStartedScreen()),
                  );
                },
                style: ThemeConstants.primaryButton,
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
