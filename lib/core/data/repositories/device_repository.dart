import 'package:shared_preferences/shared_preferences.dart';
import '../models/device_model.dart';

class DeviceRepository {
  static const String _deviceListKey = 'device_list';

  Future<void> saveDevice(DeviceModel device) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> deviceList = prefs.getStringList(_deviceListKey) ?? [];

    // Adiciona o novo dispositivo na lista
    deviceList.add(device.toMap().toString());
    await prefs.setStringList(_deviceListKey, deviceList);
  }

  Future<List<DeviceModel>> getDeviceList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> deviceList = prefs.getStringList(_deviceListKey) ?? [];

    // Converte a lista de Strings de volta para uma lista de DeviceModel
    return deviceList.map((e) {
      Map<String, dynamic> map = _convertStringToMap(e);
      return DeviceModel.fromMap(map);
    }).toList();
  }

  Future<void> clearDeviceList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceListKey);
  }

  // Método auxiliar para converter uma String em um Map
  Map<String, dynamic> _convertStringToMap(String deviceString) {
    final Map<String, dynamic> map = {};
    final entries = deviceString.substring(1, deviceString.length - 1).split(', ');

    for (var entry in entries) {
      final keyValue = entry.split(': ');
      if (keyValue.length == 2) {
        map[keyValue[0]] = keyValue[1].replaceAll("'", ""); // Remove aspas simples
      }
    }
    return map;
  }
}
