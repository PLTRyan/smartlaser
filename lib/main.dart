import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_laser/core/router.dart';
import 'models/laser_model.dart';
import 'services/laser_service.dart';
import 'widgets/laser_beam_display.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SmartLaserApp(),
    ),
  );
}

class SmartLaserApp extends ConsumerWidget {
  const SmartLaserApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Smart Laser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LaserService _laserService = LaserService();
  final List<String> _availableModes = ['Normal', 'Pulse', 'Continuous', 'Pattern'];
  
  @override
  void dispose() {
    _laserService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder<LaserModel>(
        stream: _laserService.laserStream,
        initialData: _laserService.currentLaser,
        builder: (context, snapshot) {
          final laser = snapshot.data!;
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                // Laser beam display
                LaserBeamDisplay(laser: laser),
                
                const SizedBox(height: 16),
                
                // Laser status indicator
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Laser Status:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: laser.isOn ? Colors.red : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              laser.isOn ? 'ON' : 'OFF',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: laser.isOn ? Colors.red : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),

                // Intensity slider
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Laser Intensity:',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${laser.intensity.toInt()}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: laser.intensity,
                          min: 0,
                          max: 100,
                          divisions: 20,
                          label: '${laser.intensity.toInt()}%',
                          onChanged: laser.isOn
                              ? (value) => _laserService.setIntensity(value)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Mode selection
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Operation Mode:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: laser.mode,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onChanged: laser.isOn
                              ? (String? value) {
                                  if (value != null) {
                                    _laserService.setMode(value);
                                  }
                                }
                              : null,
                          items: _availableModes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Display last toggled time if available
                if (laser.lastToggled != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Last Toggled:',
                            style: TextStyle(fontSize: 18),
                          ),
            Text(
                            _formatDateTime(laser.lastToggled!),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
            ),
          ],
        ),
      ),
                  ),
                ],
                
                const Spacer(),
                
                // Power button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    icon: Icon(laser.isOn ? Icons.power_settings_new : Icons.power_off),
                    label: Text(
                      laser.isOn ? 'Turn Off' : 'Turn On',
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: laser.isOn ? Colors.grey[800] : Colors.red,
                    ),
                    onPressed: () => _laserService.toggleLaser(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Helper method to format DateTime
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    final time = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    
    if (date == today) {
      return 'Today, $time';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}, $time';
    }
  }
}
