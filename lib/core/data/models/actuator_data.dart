class ActuatorData {
  String actuatorId;
  DateTime timestamp;
  String command;

  ActuatorData({
    required this.actuatorId,
    required this.timestamp,
    required this.command,
  });

  // Método para converter um objeto ActuatorData em um Map
  Map<String, dynamic> toMap() {
    return {
      'ActuatorId': actuatorId,
      'Timestamp': timestamp.toIso8601String(),
      'Command': command,
    };
  }

  // Método para criar um objeto ActuatorData a partir de um Map
  factory ActuatorData.fromMap(Map<String, dynamic> map) {
    return ActuatorData(
      actuatorId: map['actuatorId'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      command: map['command'] ?? '',
    );
  }
}
