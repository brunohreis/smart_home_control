import 'package:uuid/uuid.dart';

class EspModel {
  String id;
  String mac;
  String name;

  EspModel({
    String? id,
    required this.mac,
    required this.name,
  }) : id = id ?? Uuid().v4(); // Gera um UUID se id não for fornecido

  // Método para converter um objeto EspModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mac': mac,
      'name': name,
    };
  }

  // Método para criar um objeto EspModel a partir de um Map
  factory EspModel.fromMap(Map<String, dynamic> map) {
    return EspModel(
      id: map['id'] ?? '',
      mac: map['mac'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
