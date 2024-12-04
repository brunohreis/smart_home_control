import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smart_home_control/core/data/api/dio_client.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';

class FirebaseService {
  final Dio api = DioClient.getInstance();
  final String baseUrl = '/esp';
  final String sensorUrl = '/sensor';
  final String actuatorUrl = '/actuator';

  // GET /api/Esp
  Future<List<EspModel>> getEspList() async {
    try {
      final response = await api.get(baseUrl);

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => EspModel.fromMap(json))
              .toList();
        } else {
          throw Exception('Dados inválidos retornados pela API');
        }
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
      final response = await api.post(
        baseUrl,
        data: jsonEncode(esp.toMap()),
      );

      if (response.statusCode == 200) {
        print('200 ${response.data}');
        return esp;
      } else {
        print('else: $response');
        throw Exception('Failed to add esp: ${response.statusCode}');
      }
    } catch (e) {
      print('catch: $e');
      throw Exception('Failed to add esp: $e');
    }
  }

  // GET /api/Esp/{id}
  Future<EspModel> getEspById(String id) async {
    try {
      final response = await api.get('$baseUrl/$id');

      if (response.statusCode == 200) {
        return EspModel.fromMap(jsonDecode(response.data));
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
      final response = await api.delete('$baseUrl/$id');

      if (response.statusCode == 204) {
        // Exclusão bem-sucedida, nenhuma ação necessária
      } else if (response.statusCode == 409) {
        throw Exception(response.data);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // GET /api/Esp/{id}/sensors
  Future<List<SensorModel>> getSensorsByEspId(String id) async {
    try {
      final response = await api.get('$baseUrl/$id/sensors');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.data);
        return jsonResponse.map((json) => SensorModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch sensors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch sensors: $e');
    }
  }

  // POST /api/Sensor
  Future<void> addSensor(SensorModel sensor) async {
    try {
      final response = await api.post(
        sensorUrl,
        data: jsonEncode(sensor.toMap()),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to add sensor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add sensor: $e');
    }
  }

  // GET /api/Sensor/{espId}
  Future<List<SensorModel>> getSensors(String espId) async {
    try {
      final response = await api.get('$sensorUrl/$espId');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => SensorModel.fromMap(json))
              .toList();
        } else {
          throw Exception('Invalid data returned for sensors');
        }
      } else {
        throw Exception('Failed to fetch sensors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch sensors: $e');
    }
  }

  // GET /api/Sensor/{espId}/{id}
  Future<SensorModel> getSensorById(String espId, String id) async {
    try {
      final response = await api.get('$sensorUrl/$espId/$id');

      if (response.statusCode == 200) {
        return SensorModel.fromMap(jsonDecode(response.data));
      } else {
        throw Exception('Failed to fetch sensor by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch sensor by ID: $e');
    }
  }

  // DELETE /api/Sensor/{espId}/{id}
  Future<void> deleteSensor(String espId, String id) async {
    try {
      final response = await api.delete('$sensorUrl/$espId/$id');

      if (response.statusCode == 204) {
        print('Sensor deleted successfully');
      } else {
        throw Exception('Failed to delete sensor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete sensor: $e');
    }
  }

  // GET /api/Esp/{id}/actuators
  Future<List<ActuatorModel>> getActuatorsByEspId(String id) async {
    try {
      final response = await api.get('$baseUrl/$id/actuators');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.data);
        return jsonResponse.map((json) => ActuatorModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to fetch actuators: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch actuators: $e');
    }
  }

  // POST /api/Esp/{id}/actuators
  Future<void> addActuator(ActuatorModel actuator) async {
    try {
      final response = await api.post(
        actuatorUrl,
        data: jsonEncode(actuator.toMap()),
      );

      if (response.statusCode == 200) {
        print('Actuator added successfully');
      } else {
        throw Exception('Failed to add actuator: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add actuator: $e');
    }
  }

  // DELETE /api/Esp/{espId}/actuators/{id}
  Future<void> deleteActuator(String espId, String id) async {
    try {
      final response = await api.delete('$actuatorUrl/$espId/$id');

      if (response.statusCode == 204) {
        print('Actuator deleted successfully');
      } else {
        throw Exception('Failed to delete actuator: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete actuator: $e');
    }
  }
}
