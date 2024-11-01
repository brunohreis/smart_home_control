import 'package:smart_home_control/core/data/models/device_type.dart';
import 'package:uuid/uuid.dart';

class DeviceModel {
  int id = 0;
  String description;
  DeviceType type; // Usando a enumeração

  DeviceModel({
    id,
    required this.description,
    required this.type,
  });

  // Método para converter um objeto DeviceModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'type': type.toString().split('.').last, // Converte para string
    };
  }

  // Método para criar um objeto DeviceModel a partir de um Map
  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      type: DeviceType.values.firstWhere((e) => e.toString() == 'DeviceType.${map['type']}'), // Converte de volta para enum
    );
  }
}
