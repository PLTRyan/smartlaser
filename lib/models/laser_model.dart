class LaserModel {
  bool isOn;
  double intensity;
  String mode;
  DateTime? lastToggled;

  LaserModel({
    this.isOn = false,
    this.intensity = 50.0,
    this.mode = 'Normal',
    this.lastToggled,
  });

  void toggle() {
    isOn = !isOn;
    lastToggled = DateTime.now();
  }

  void setIntensity(double value) {
    if (value >= 0 && value <= 100) {
      intensity = value;
    }
  }

  void setMode(String newMode) {
    final validModes = ['Normal', 'Pulse', 'Continuous', 'Pattern'];
    if (validModes.contains(newMode)) {
      mode = newMode;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'isOn': isOn,
      'intensity': intensity,
      'mode': mode,
      'lastToggled': lastToggled?.toIso8601String(),
    };
  }

  factory LaserModel.fromJson(Map<String, dynamic> json) {
    return LaserModel(
      isOn: json['isOn'] as bool? ?? false,
      intensity: json['intensity'] as double? ?? 50.0,
      mode: json['mode'] as String? ?? 'Normal',
      lastToggled: json['lastToggled'] != null 
          ? DateTime.parse(json['lastToggled'] as String)
          : null,
    );
  }
} 