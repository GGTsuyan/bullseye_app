import 'package:flutter/material.dart';
import '../../theme/theme_constants.dart';
import '../home_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;

  const EmailVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.primaryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ThemeConstants.primaryBlack,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Continue with email',
          style: TextStyle(
            color: ThemeConstants.primaryBlack,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Welcome!',
                style: ThemeConstants.headingLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a code that we sent to $email to finish signing up.',
                style: ThemeConstants.bodyText,
              ),
              const SizedBox(height: 32),
              TextField(
                decoration: ThemeConstants.inputDecoration('Enter code'),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                style: ThemeConstants.primaryButton,
                child: const Text('Continue'),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Implement resend code logic
                  },
                  child: Text(
                    'Resend code',
                    style: ThemeConstants.buttonText.copyWith(
                      color: ThemeConstants.primaryBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
