import 'package:shared_preferences/shared_preferences.dart';
import '../models/esp_model.dart';

class EspRepository {
  static const String _espListKey = 'esp_list';

  Future<void> saveEsp(EspModel esp) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> espList = prefs.getStringList(_espListKey) ?? [];

    // Adiciona a nova placa na lista
    espList.add(esp.toMap().toString());
    await prefs.setStringList(_espListKey, espList);
  }

  Future<List<EspModel>> getEspList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> espList = prefs.getStringList(_espListKey) ?? [];

    // Converte a lista de Strings de volta para uma lista de EspModel
    return espList.map((e) {
      Map<String, dynamic> map = _convertStringToMap(e);
      return EspModel.fromMap(map);
    }).toList();
  }

  Future<void> clearEspList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_espListKey);
  }

  // Método auxiliar para converter uma String em um Map
  Map<String, dynamic> _convertStringToMap(String espString) {
    final Map<String, dynamic> map = {};
    final entries = espString.substring(1, espString.length - 1).split(', ');

    for (var entry in entries) {
      final keyValue = entry.split(': ');
      if (keyValue.length == 2) {
        map[keyValue[0]] = keyValue[1];
      }
    }
    return map;
  }
}
