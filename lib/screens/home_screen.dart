import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F4),
      body: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            color: const Color(0xFFD45745),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Welcome, $name',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              '🏠 Home screen content here...',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
