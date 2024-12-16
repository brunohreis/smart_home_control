import 'package:flutter/material.dart';

class AlertModel {
  String sensorId; // Identificador do sensor associado
  String sensorName; // Nome do sensor associado
  double value; // Valor do alerta

  AlertModel({
    required this.sensorId,
    required this.sensorName,
    required this.value,
  });

  // Método para converter um objeto AlertModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'sensorId': sensorId,
      'sensorName': sensorName,
      'value': value,
    };
  }

  // Método para criar um objeto AlertModel a partir de um Map
  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      sensorId: map['sensorId'] ?? '',
      sensorName: map['sensorName'] ?? '',
      value: (map['value'] ?? 0.0).toDouble(),
    );
  }
}
