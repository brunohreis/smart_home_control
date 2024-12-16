import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/sensor_data.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/temperature_gauge/temperature_gauge.dart';

import 'sensor_type.dart';

class SensorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  SensorType type; // Usando enum SensorType
  String espId;
  SensorData? lastData;

  SensorModel({
    required this.id,
    required this.name,
    required this.type,
    required this.espId,
    this.lastData,
  });

  SensorType get typeSensor => type; // Getter para compatibilidade

  // Método para converter um objeto SensorModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index, // Armazena o índice do enum
      'espId': espId,
      'lastData': lastData?.toMap(), // Serializa lastData se não for nulo
    };
  }

  // Método para criar um objeto SensorModel a partir de um Map
  factory SensorModel.fromMap(Map<String, dynamic> map) {
    return SensorModel(
      id: map['id'] ?? '', // Garantir que 'id' não seja nulo
      name: map['name'] ?? '',
      type: SensorType.values[map['type'] ?? 0], // Converte índice para enum
      espId: map['espId'] ?? '',
      lastData: map['lastData'] != null ? SensorData.fromMap(map['lastData']) : null,
    );
  }

  /// Retorna o widget correspondente ao tipo do sensor.
  Widget getCorrespondingWidget() {
    switch (type) {
      case SensorType.DHT11:
        return TemperatureGauge(
          temperatureValue: lastData?.valueAsDouble ?? 0.0,
        );
      case SensorType.NTC:
        return TemperatureGauge(
          temperatureValue: lastData?.valueAsDouble ?? 0.0,
        );
      // Outros tipos de sensores podem ser implementados aqui futuramente.
      default:
        return Text("Sensor não suportado.");
    }
  }
}
