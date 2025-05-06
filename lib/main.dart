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
          seedColor: Colors.redAccent,
          brightness: Brightness.light,
          primary: Colors.redAccent,
          secondary: Colors.amberAccent,
          background: Colors.white,
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF2374E1), // Facebook blue
          onPrimary: Color(0xFFE4E6EB),
          secondary: Color(0xFF2374E1),
          onSecondary: Color(0xFFE4E6EB),
          background: Color(0xFF18191A),
          onBackground: Color(0xFFE4E6EB),
          surface: Color(0xFF242526),
          onSurface: Color(0xFFE4E6EB),
          error: Colors.red,
          onError: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFF18191A),
        cardTheme: CardTheme(
          color: Color(0xFF242526),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Color(0xFF3E4042)),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF3E4042)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF3E4042)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF2374E1), width: 2),
          ),
          filled: true,
          fillColor: Color(0xFF3A3B3C),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Color(0xFFB0B3B8)),
          labelStyle: TextStyle(color: Color(0xFFB0B3B8)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3A3B3C),
            foregroundColor: Color(0xFFE4E6EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF2374E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF3E4042)),
            ),
            filled: true,
            fillColor: Color(0xFF3A3B3C),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF242526),
          foregroundColor: Color(0xFFE4E6EB),
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFFE4E6EB),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE4E6EB)),
          bodyMedium: TextStyle(color: Color(0xFFE4E6EB)),
          bodySmall: TextStyle(color: Color(0xFFB0B3B8)),
          titleLarge: TextStyle(color: Color(0xFFE4E6EB)),
          titleMedium: TextStyle(color: Color(0xFFE4E6EB)),
          titleSmall: TextStyle(color: Color(0xFFB0B3B8)),
        ),
      ),
      themeMode: ThemeMode.dark,
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
