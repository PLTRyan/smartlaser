import 'dart:async';
import '../models/laser_model.dart';

/// A service that simulates laser operations.
class LaserService {
  LaserModel _laserModel = LaserModel();
  final _controller = StreamController<LaserModel>.broadcast();
  Timer? _operationTimer;

  LaserService() {
    // Initial state
    _controller.add(_laserModel);
  }

  // Get the current laser model as a stream
  Stream<LaserModel> get laserStream => _controller.stream;

  // Get the current laser model
  LaserModel get currentLaser => _laserModel;

  // Toggle the laser state
  Future<void> toggleLaser() async {
    _laserModel.toggle();
    _controller.add(_laserModel);
    
    // If laser turned on, start simulated operations
    if (_laserModel.isOn) {
      _startOperations();
    } else {
      _stopOperations();
    }
  }

  // Set the laser intensity
  void setIntensity(double intensity) {
    _laserModel.setIntensity(intensity);
    _controller.add(_laserModel);
  }

  // Set the laser operation mode
  void setMode(String mode) {
    _laserModel.setMode(mode);
    _controller.add(_laserModel);
    
    // Restart operations if the laser is on
    if (_laserModel.isOn) {
      _stopOperations();
      _startOperations();
    }
  }

  // Simulate laser operations based on the current mode
  void _startOperations() {
    // Cancel any existing timer
    _stopOperations();
    
    // Different behaviors based on the mode
    switch (_laserModel.mode) {
      case 'Pulse':
        _operationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          // Simulate pulsing behavior
          _laserModel.isOn = !_laserModel.isOn;
          _controller.add(_laserModel);
          
          // Always turn it back on after half a second if it was turned off
          if (!_laserModel.isOn) {
            Timer(const Duration(milliseconds: 500), () {
              _laserModel.isOn = true;
              _controller.add(_laserModel);
            });
          }
        });
        break;
      
      case 'Pattern':
        // A more complex pattern changing intensity
        _operationTimer = Timer.periodic(const Duration(milliseconds: 800), (_) {
          // Cycle through 3 intensity levels
          final currentIntensity = _laserModel.intensity;
          if (currentIntensity > 80) {
            _laserModel.setIntensity(30);
          } else if (currentIntensity < 50) {
            _laserModel.setIntensity(80);
          } else {
            _laserModel.setIntensity(100);
          }
          _controller.add(_laserModel);
        });
        break;
        
      // For Normal and Continuous modes, we don't need a timer
      default:
        break;
    }
  }

  // Stop any ongoing operations
  void _stopOperations() {
    _operationTimer?.cancel();
    _operationTimer = null;
  }

  // Clean up resources
  void dispose() {
    _stopOperations();
    _controller.close();
  }
} 