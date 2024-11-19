class EspModel {
  int id;
  String mac;
  String name;

  EspModel({
    required this.id,
    required this.mac,
    required this.name,
  });

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
      id: map['id'],
      mac: map['mac'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
