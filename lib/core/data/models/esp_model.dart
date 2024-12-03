import 'package:smart_home_control/core/data/models/actuator_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';

class EspModel {
  String id;
  String macAddress;
  String name;
  List<SensorModel>? sensors;
  List<ActuatorModel>? actuators;

  EspModel({
    required this.id,
    required this.macAddress,
    required this.name,
    this.sensors,
    this.actuators,
  });

  // Método para converter um objeto EspModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'macAddress': macAddress,
      'name': name,
      'sensors': sensors?.map((sensor) => sensor.toMap()).toList(),
      'actuators': actuators?.map((actuator) => actuator.toMap()).toList(),
    };
  }

  // Método para criar um objeto EspModel a partir de um Map
  factory EspModel.fromMap(Map<String, dynamic> map) {
    return EspModel(
      id: map['id'],
      macAddress: map['macAddress'] ?? '',
      name: map['name'] ?? '',
      sensors: (map['sensors'] is List)
          ? (map['sensors'] as List<dynamic>)
              .map((sensorMap) => SensorModel.fromMap(sensorMap))
              .toList()
          : null,
      actuators: (map['actuators'] is List)
          ? (map['actuators'] as List<dynamic>)
              .map((actuatorMap) => ActuatorModel.fromMap(actuatorMap))
              .toList()
          : null,
    );
  }
}
