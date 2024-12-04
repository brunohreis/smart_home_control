import 'actuator_type.dart';

class ActuatorModel {
  String id; // Gerado automaticamente como um UUID
  String name;
  int outputPin;
  ActuatorType typeActuator; // Usando enum ActuatorType
  String espId;
  bool isDigital;

  ActuatorModel({
    required this.id,
    required this.name,
    required this.outputPin,
    required this.typeActuator,
    required this.espId,
    required this.isDigital,
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
    );
  }
}
