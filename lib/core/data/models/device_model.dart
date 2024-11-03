import 'package:flutter/cupertino.dart';
import 'package:smart_home_control/core/data/models/device_type.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/boolean_device/boolean_device.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/humidity_gauge/humidity_gauge.dart';
import 'package:smart_home_control/features/dashboard/presentation/components/temperature_gauge/temperature_gauge.dart';

class DeviceModel implements Comparable<DeviceModel>{
  int id;
  String name;
  DeviceType type; // Usando a enumeração

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
  });

  // Método para converter um objeto DeviceModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
    };
  }

  // Método para criar um objeto DeviceModel a partir de um Map
  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'],
      name: map['name'] ?? '',
      type: DeviceType.values[map['type']],
    );
  }
  Widget getCorrespondingWidget(){
    switch (type){
      case DeviceType.temperature:
        return TemperatureGauge(temperatureValue: getCurrentValue());
      case DeviceType.humidity:
        return HumidityGauge(humidityValue: getCurrentValue());
      default:
        return BooleanDevice(value: getCurrentValue());
    }
  }
  getCurrentValue(){
    // Aqui virá a lógica de seleção do valor retornado pelo dispositivo no banco de dados
    // O que está implementado atualmente só serve para fins de teste
    switch (type){
      case DeviceType.temperature:
        return 35.0;
      case DeviceType.humidity:
        return 60.0;
      default:
        return true;
    }
  }
  bool isSensor(){
    if (type == DeviceType.temperature || type == DeviceType.humidity){
      return true;
    }
    else{
      return false;
    }
  }
  @override
  int compareTo(DeviceModel other) {
    if (type.index < other.type.index) {
      return -1;
    } else if (type.index > other.type.index) {
      return 1;
    } else {
      return 0;
    }
  }
}
