import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';

class EspService {
  final String baseUrl = 'https://localhost:7208/api/Esp';

  // GET /api/Esp
  Future<List<EspModel>> getEspList() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((json) => EspModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch esp list: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch esp list: $e');
    }
  }

  // POST /api/Esp
  Future<EspModel> addEsp(EspModel esp) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(esp.toMap()),
      );

      if (response.statusCode == 201) {
        return EspModel.fromMap(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add esp: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add esp: $e');
    }
  }

  // GET /api/Esp/{id}
  Future<EspModel> getEspById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        return EspModel.fromMap(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch esp by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch esp by ID: $e');
    }
  }

  // DELETE /api/Esp/{id}
  Future<void> deleteEsp(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete esp: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete esp: $e');
    }
  }

  // GET /api/Esp/{id}/sensors
  Future<List<SensorModel>> getSensorsByEspId(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id/sensors'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((json) => SensorModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch sensors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch sensors: $e');
    }
  }

  // GET /api/Esp/{id}/actuators
  Future<List<ActuatorModel>> getActuatorsByEspId(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id/actuators'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((json) => ActuatorModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch actuators: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch actuators: $e');
    }
  }
}
