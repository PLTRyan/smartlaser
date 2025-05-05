import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/laser_model.dart';

class LaserBeamDisplay extends StatefulWidget {
  final LaserModel laser;

  const LaserBeamDisplay({
    super.key,
    required this.laser,
  });

  @override
  State<LaserBeamDisplay> createState() => _LaserBeamDisplayState();
}

class _LaserBeamDisplayState extends State<LaserBeamDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(4),
        ),
        child: widget.laser.isOn
            ? Stack(
                children: [
                  // Base position of laser source
                  const Positioned(
                    left: 20,
                    top: 75,
                    child: Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  
                  // Visual laser beam
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(double.infinity, 150),
                        painter: LaserBeamPainter(
                          isOn: widget.laser.isOn,
                          intensity: widget.laser.intensity,
                          mode: widget.laser.mode,
                          animationValue: _animationController.value,
                        ),
                      );
                    },
                  ),
                  
                  // Intensity label
                  Positioned(
                    right: 16,
                    bottom: 8,
                    child: Text(
                      'Intensity: ${widget.laser.intensity.toInt()}%',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  
                  // Mode label
                  Positioned(
                    left: 16,
                    bottom: 8,
                    child: Text(
                      'Mode: ${widget.laser.mode}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'LASER OFF',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}

class LaserBeamPainter extends CustomPainter {
  final bool isOn;
  final double intensity;
  final String mode;
  final double animationValue;

  LaserBeamPainter({
    required this.isOn,
    required this.intensity,
    required this.mode,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isOn) return;
    
    // Starting point of laser
    final startPoint = Offset(28, size.height / 2);
    // Endpoint of laser (right edge of screen)
    final endPoint = Offset(size.width, size.height / 2);
    
    // Base laser color is red
    final baseColor = Colors.red.withOpacity(intensity / 100);
    final glowColor = Colors.red.withOpacity(intensity / 200);
    
    // Calculate beam width based on intensity
    final beamWidth = 2.0 + (intensity / 25);
    
    // Create paint for the main beam
    final beamPaint = Paint()
      ..color = baseColor
      ..strokeWidth = beamWidth
      ..strokeCap = StrokeCap.round;
    
    // Create a second paint for the glow effect
    final glowPaint = Paint()
      ..color = glowColor
      ..strokeWidth = beamWidth * 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    
    // Draw the beam according to the mode
    switch (mode) {
      case 'Pulse':
        // Pulsing effect
        final pulseScale = (math.sin(animationValue * math.pi * 2) + 1) / 2;
        beamPaint.color = baseColor.withOpacity(baseColor.opacity * pulseScale);
        glowPaint.color = glowColor.withOpacity(glowColor.opacity * pulseScale);
        
        canvas.drawLine(startPoint, endPoint, glowPaint);
        canvas.drawLine(startPoint, endPoint, beamPaint);
        break;
        
      case 'Pattern':
        // Draw a zigzag pattern
        final path = Path();
        path.moveTo(startPoint.dx, startPoint.dy);
        
        // Number of zigzags based on width
        final segments = (size.width - startPoint.dx) / 30;
        final amplitude = 10.0 + (intensity / 10);
        
        // Create a zigzag pattern with animation
        final phaseShift = animationValue * math.pi * 2;
        
        for (var i = 0; i <= segments; i++) {
          final x = startPoint.dx + (i * 30);
          final yOffset = math.sin(i + phaseShift) * amplitude;
          path.lineTo(x, startPoint.dy + yOffset);
        }
        
        canvas.drawPath(path, glowPaint);
        canvas.drawPath(path, beamPaint);
        break;
        
      case 'Continuous':
        // Steady beam with small variations to make it look dynamic
        final noise = math.sin(animationValue * math.pi * 10) * 0.05;
        beamPaint.color = baseColor.withOpacity(baseColor.opacity * (1 + noise));
        
        canvas.drawLine(startPoint, endPoint, glowPaint);
        canvas.drawLine(startPoint, endPoint, beamPaint);
        break;
        
      default: // 'Normal' mode
        // Simple static beam
        canvas.drawLine(startPoint, endPoint, glowPaint);
        canvas.drawLine(startPoint, endPoint, beamPaint);
        break;
    }
    
    // Draw the laser source point
    final sourcePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(startPoint, 4, sourcePaint);
  }

  @override
  bool shouldRepaint(LaserBeamPainter oldDelegate) {
    return oldDelegate.isOn != isOn ||
        oldDelegate.intensity != intensity ||
        oldDelegate.mode != mode ||
        oldDelegate.animationValue != animationValue;
  }
} 