import 'package:smart_home_control/core/data/models/actuator_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';

class DevicesModel {
  List<SensorModel>? sensors;
  List<ActuatorModel>? actuators;

  DevicesModel({
    this.sensors,
    this.actuators,
  });

  // Método para converter um objeto DevicesModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'sensors': sensors?.map((sensor) => sensor.toMap()).toList(),
      'actuators': actuators?.map((actuator) => actuator.toMap()).toList(),
    };
  }

  // Método para criar um objeto DevicesModel a partir de um Map
  factory DevicesModel.fromMap(Map<String, dynamic> map) {
    return DevicesModel(
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
