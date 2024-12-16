import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/models/actuator_data.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/boolean_device/boolean_device.dart';

import 'actuator_type.dart';
class ActuatorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  ActuatorType typeActuator; // Usando enum ActuatorType
  String espId;
  ActuatorData? lastData; // Atributo opcional para armazenar o último comando
  String? macAddress;

  ActuatorModel({
    required this.id,
    required this.name,
    required this.typeActuator,
    required this.espId,
    this.lastData,
    this.macAddress,
  });

  // Método para converter um objeto ActuatorModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'typeActuator': typeActuator.index, // Armazena o índice do enum
      'espId': espId,
      'lastData': lastData?.toMap(), // Serializa lastData se não for nulo
      'macAddress': macAddress,
    };
  }

  // Método para criar um objeto ActuatorModel a partir de um Map
  factory ActuatorModel.fromMap(Map<String, dynamic> map) {
    return ActuatorModel(
      id: map['id'] ?? '', // Garantir que 'id' não seja nulo
      name: map['name'] ?? '',
      typeActuator: ActuatorType.values[map['typeActuator'] ?? 0], // Converte índice para enum
      espId: map['espId'] ?? '',
      lastData: map['lastData'] != null ? ActuatorData.fromMap(map['lastData']) : null,
      macAddress: map['macAddress'] ?? '',
    );
  }

  /// Retorna o widget correspondente ao tipo do atuador.
  Widget getCorrespondingWidget(ActuatorModel actuator) {
    // Usando lastData para determinar o valor booleano do Switch
    bool currentValue = lastData?.command == "turnOn";

    switch (typeActuator) {
      case ActuatorType.Lampada:
        return BooleanDevice(
        value: currentValue,
        actuator: actuator,
      );
      // Outros tipos de atuadores podem ser implementados aqui futuramente.
      default:
        return Text("Atuador não suportado.");
    }
  }
}
