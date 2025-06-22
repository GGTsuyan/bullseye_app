import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      appBar: AppBar(
        title: const Text('Dart Tracking'),
      ),
      body: _errorMessage != null
          ? Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            )
          : !_isCameraInitialized
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          CameraPreview(_controller!),
                          // Overlay for round and throw information
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Round: $_currentRound',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Throw: $_currentThrow',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.black, width: 1),
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
                                    backgroundColor: _isTracking ? Colors.red : Colors.black,
                                  ),
                                  child: Text(
                                    _isTracking ? 'Stop Tracking' : 'Start Tracking',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _nextThrow,
                                  child: const Text('Next Throw'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isTracking ? 'Tracking Active' : 'Tracking Inactive',
                            style: TextStyle(
                              color: _isTracking ? Colors.red : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
