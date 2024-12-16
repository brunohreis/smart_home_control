class SensorData {
  String sensorId;
  DateTime timestamp;
  String value;

  SensorData({
    required this.sensorId,
    required this.timestamp,
    required this.value,
  });

  // Método para converter um objeto SensorData em um Map
  Map<String, dynamic> toMap() {
    return {
      'sensorId': sensorId,
      'timestamp': timestamp.toIso8601String(),
      'value': value,
    };
  }

  // Método para criar um objeto SensorData a partir de um Map
  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      sensorId: map['sensorId'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      value: map['value'] ?? '0',
    );
  }

  /// Getter para retornar o valor como double
  double get valueAsDouble => double.tryParse(value) ?? 0.0;
}
