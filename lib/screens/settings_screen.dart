import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'statistics_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'CAMERA SETTINGS',
                      children: [
                        _buildSettingItem(
                          'Detection Model',
                          trailing: Row(
                            children: [
                              const Text(
                                'Latest',
                                style: TextStyle(color: Color(0xFFD4AF37)),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        _buildSettingItem(
                          'Confidence Threshold',
                          subtitle: 'Increasing will help prevent duplicate detections, but will also reduce detection rates for hidden darts. Default: 0.75.',
                          trailing: const Text(
                            '0.75',
                            style: TextStyle(color: Colors.white70),
                          ),
                          showSlider: true,
                        ),
                        _buildSettingItem(
                          'Distance Threshold',
                          subtitle: 'Increasing will help prevent duplicate detections, but will also reduce detection rates for tightly grouped darts. Default: 2.0 mm.',
                          trailing: const Text(
                            '2.0 mm',
                            style: TextStyle(color: Colors.white70),
                          ),
                          showSlider: true,
                        ),
                        _buildSettingItem(
                          'Camera',
                          trailing: Row(
                            children: [
                              const Text(
                                'Back Camera',
                                style: TextStyle(color: Color(0xFFD4AF37)),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        _buildSettingItem(
                          'Camera Zoom',
                          showSlider: true,
                        ),
                        _buildSettingItem(
                          'Video Rotation',
                          trailing: Row(
                            children: [
                              const Text(
                                'Automatic',
                                style: TextStyle(color: Color(0xFFD4AF37)),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'GAMEPLAY SETTINGS',
                      children: [
                        _buildSettingItem(
                          'Show stats between legs',
                          subtitle: 'Does not apply for online games.',
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFFD4AF37),
                          ),
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'AUDIO SETTINGS',
                      children: [
                        _buildSettingItem(
                          'Voice',
                          trailing: Row(
                            children: [
                              const Text(
                                'Nicky (United States)',
                                style: TextStyle(color: Color(0xFFD4AF37)),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        _buildSettingItem(
                          'Dart Sounds',
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFFD4AF37),
                          ),
                        ),
                        _buildSettingItem(
                          'Score Caller',
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFFD4AF37),
                          ),
                        ),
                        _buildSettingItem(
                          'Checkout Caller',
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFFD4AF37),
                          ),
                        ),
                      ],
                    ),
                    _buildSection(
                      title: 'ABOUT',
                      children: [
                        _buildSettingItem(
                          'Terms of Use',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                        _buildSettingItem(
                          'Privacy Policy',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    String title, {
    String? subtitle,
    Widget? trailing,
    bool showSlider = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
          if (showSlider) ...[
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFFD4AF37),
                inactiveTrackColor: Colors.grey[800],
                thumbColor: Colors.white,
                overlayColor: Colors.white.withOpacity(0.1),
                trackHeight: 4,
              ),
              child: Slider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[800]!,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
          _buildNavItem(
            icon: Icons.bar_chart,
            label: 'Statistics',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StatisticsScreen()),
              );
            },
          ),
          _buildNavItem(
            icon: Icons.settings,
            label: 'Settings',
            isSelected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
