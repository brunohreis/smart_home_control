import 'package:flutter/material.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/temperature_gauge/temperature_gauge.dart';

import 'sensor_type.dart';

class SensorData {
  String sensorId;
  DateTime timestamp;
  int value;

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
      value: map['value'] ?? 0,
    );
  }
}

class SensorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  int pin1;
  int? pin2; // Opcional
  SensorType type; // Usando enum SensorType
  String espId;
  bool isDigital;
  SensorData? lastData;

  SensorModel({
    required this.id,
    required this.name,
    required this.pin1,
    this.pin2,
    required this.type,
    required this.espId,
    required this.isDigital,
    this.lastData,
  });

  // Método para converter um objeto SensorModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pin1': pin1,
      'pin2': pin2,
      'type': type.index, // Armazena o índice do enum
      'espId': espId,
      'isDigital': isDigital,
      'lastData': lastData?.toMap(), // Serializa lastData se não for nulo
    };
  }

  // Método para criar um objeto SensorModel a partir de um Map
  factory SensorModel.fromMap(Map<String, dynamic> map) {
    return SensorModel(
      id: map['id'] ?? '', // Garantir que 'id' não seja nulo
      name: map['name'] ?? '',
      pin1: map['pin1'] ?? 0, // Valor padrão para pin1 caso não exista
      pin2: map['pin2'], // Aceitar nulo
      type: SensorType.values[map['type'] ?? 0], // Converte índice para enum
      espId: map['espId'] ?? '',
      isDigital: map['isDigital'] ?? false,
      lastData: map['lastData'] != null ? SensorData.fromMap(map['lastData']) : null,
    );
  }

  /// Retorna o widget correspondente ao tipo do sensor.
  Widget getCorrespondingWidget() {
    switch (type) {
      case SensorType.DHT11:
        return TemperatureGauge(
          temperatureValue: (lastData?.value ?? 0).toDouble(),
        );
      // Outros tipos de sensores podem ser implementados aqui futuramente.
      default:
        return Text("Sensor não suportado.");
    }
  }
}
