class EspModel {
  String id;
  String macAddress;
  String name;

  EspModel({
    required this.id,
    required this.macAddress,
    required this.name,
  });

  // Método para converter um objeto EspModel em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'macAddress': macAddress,
      'name': name,
    };
  }

  // Método para criar um objeto EspModel a partir de um Map
  factory EspModel.fromMap(Map<String, dynamic> map) {
    return EspModel(
      id: map['id'],
      macAddress: map['macAddress'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
