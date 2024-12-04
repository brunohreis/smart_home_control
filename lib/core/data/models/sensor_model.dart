import 'sensor_type.dart';

class SensorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  int pin1;
  int? pin2; // Opcional
  SensorType type; // Usando enum SensorType
  String espId;
  bool isDigital;

  SensorModel({
    required this.id,
    required this.name,
    required this.pin1,
    this.pin2,
    required this.type,
    required this.espId,
    required this.isDigital,
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
    );
  }
}
