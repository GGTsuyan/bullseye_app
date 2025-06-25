import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../theme/theme_constants.dart';

class DartTrackingScreen extends StatefulWidget {
  const DartTrackingScreen({Key? key}) : super(key: key);

  @override
  State<DartTrackingScreen> createState() => _DartTrackingScreenState();
}

class _DartTrackingScreenState extends State<DartTrackingScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String? _errorMessage;
  bool _isTracking = false;
  int _currentRound = 1;
  int _currentThrow = 1;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(cameras.first, ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error initializing camera: ${e.toString()}";
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleTracking() {
    setState(() {
      _isTracking = !_isTracking;
    });
  }

  void _nextThrow() {
    setState(() {
      if (_currentThrow < 3) {
        _currentThrow++;
      } else {
        _currentThrow = 1;
        _currentRound++;
      }
    });
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
          'Track Throw',
          style: TextStyle(
            color: ThemeConstants.primaryBlack,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _errorMessage != null
          ? Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(
                  color: ThemeConstants.primaryBlack,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : !_isCameraInitialized
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ThemeConstants.primaryBlack,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          CameraPreview(_controller!),
                          // Round and throw information overlay
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeConstants.primaryBlack.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Round $_currentRound',
                                    style: const TextStyle(
                                      color: ThemeConstants.primaryWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Throw $_currentThrow',
                                    style: const TextStyle(
                                      color: ThemeConstants.primaryWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tracking status indicator
                          if (_isTracking)
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: ThemeConstants.primaryBlack,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Recording',
                                      style: TextStyle(
                                        color: ThemeConstants.primaryWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: ThemeConstants.primaryWhite,
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFFEEEEEE),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _toggleTracking,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isTracking
                                        ? Colors.red
                                        : ThemeConstants.primaryBlack,
                                    foregroundColor: ThemeConstants.primaryWhite,
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    _isTracking ? 'Stop Tracking' : 'Start Tracking',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _nextThrow,
                                  style: ThemeConstants.secondaryButton,
                                  child: const Text(
                                    'Next Throw',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
