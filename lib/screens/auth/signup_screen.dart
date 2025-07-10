import 'package:flutter/material.dart';
import '../../theme/theme_constants.dart';
import 'email_verification_screen.dart';
import 'login_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_constants.dart';
import 'email_verification_screen.dart';
import 'login_screen.dart';
import '../../models/player_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final playerState = Provider.of<PlayerState>(context, listen: false);
    final username = usernameController.text.trim();
    if (username.isNotEmpty) {
      playerState.updatePlayerName(username);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmailVerificationScreen(
          email: emailController.text,
        ),
      ),
    );
  }

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
          'Sign Up',
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
            children: [
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: ThemeConstants.headingLarge,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: ThemeConstants.inputDecoration('Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: ThemeConstants.inputDecoration('Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: ThemeConstants.inputDecoration('Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onContinue,
                style: ThemeConstants.primaryButton,
                child: const Text('Continue'),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: ThemeConstants.textGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ThemeConstants.secondaryButton,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Continue with Google',
                      style: ThemeConstants.buttonText.copyWith(
                        color: ThemeConstants.primaryBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final playerState = Provider.of<PlayerState>(context, listen: false);
                  playerState.updatePlayerName('Guest');
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ThemeConstants.secondaryButton,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 24,
                      color: ThemeConstants.primaryBlack,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Continue as Guest',
                      style: ThemeConstants.buttonText.copyWith(
                        color: ThemeConstants.primaryBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: ThemeConstants.bodyText,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: ThemeConstants.buttonText.copyWith(
                        color: ThemeConstants.primaryBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
