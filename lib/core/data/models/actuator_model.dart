import 'package:flutter/material.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/boolean_device/boolean_device.dart';

import 'actuator_type.dart';

class ActuatorData {
  String actuatorId;
  DateTime timestamp;
  String command;
  int? value;

  ActuatorData({
    required this.actuatorId,
    required this.timestamp,
    required this.command,
    this.value,
  });

  // Método para converter um objeto ActuatorData em um Map
  Map<String, dynamic> toMap() {
    return {
      'actuatorId': actuatorId,
      'timestamp': timestamp.toIso8601String(),
      'command': command,
      'value': value,
    };
  }

  // Método para criar um objeto ActuatorData a partir de um Map
  factory ActuatorData.fromMap(Map<String, dynamic> map) {
    return ActuatorData(
      actuatorId: map['actuatorId'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      command: map['command'] ?? '',
      value: map['value'],
    );
  }
}

class ActuatorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  int outputPin;
  ActuatorType typeActuator; // Usando enum ActuatorType
  String espId;
  bool isDigital;
  ActuatorData? lastData; // Atributo opcional para armazenar o último comando
  String? macAddress;

  ActuatorModel({
    required this.id,
    required this.name,
    required this.outputPin,
    required this.typeActuator,
    required this.espId,
    required this.isDigital,
    this.lastData,
    this.macAddress,
  });

  // Método para converter um objeto ActuatorModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'outputPin': outputPin,
      'typeActuator': typeActuator.index, // Armazena o índice do enum
      'espId': espId,
      'isDigital': isDigital,
      'lastData': lastData?.toMap(), // Serializa lastData se não for nulo
      'macAddress': macAddress,
    };
  }

  // Método para criar um objeto ActuatorModel a partir de um Map
  factory ActuatorModel.fromMap(Map<String, dynamic> map) {
    return ActuatorModel(
      id: map['id'] ?? '', // Garantir que 'id' não seja nulo
      name: map['name'] ?? '',
      outputPin: map['outputPin'] ?? 0, // Valor padrão para outputPin caso não exista
      typeActuator: ActuatorType.values[map['typeActuator'] ?? 0], // Converte índice para enum
      espId: map['espId'] ?? '',
      isDigital: map['isDigital'] ?? false,
      lastData: map['lastData'] != null ? ActuatorData.fromMap(map['lastData']) : null,
      macAddress: map['macAddress'] ?? '',
    );
  }

  /// Retorna o widget correspondente ao tipo do atuador.
  Widget getCorrespondingWidget() {
    switch (typeActuator) {
      case ActuatorType.Rele1Canal:
        return BooleanDevice(
        value: (lastData?.value ?? 0) != 0, // Converte o valor para booleano
      );
      // Outros tipos de atuadores podem ser implementados aqui futuramente.
      default:
        return Text("Atuador não suportado.");
    }
  }
}
