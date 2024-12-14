import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smart_home_control/core/data/api/dio_client.dart';
import 'package:smart_home_control/core/data/models/devices_model.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';

class FirebaseService {
  final Dio api = DioClient.getInstance();
  final String baseUrl = '/esp';
  final String sensorUrl = '/sensor';
  final String actuatorUrl = '/actuator';
  final String mqttUrl = '/Mqtt';

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

  // GET /api/Sensor/{espId}
  Future<DevicesModel> getDevices() async {
    try {
      final response = await api.get('$baseUrl/devices');
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          // Converte o objeto JSON para um DevicesModel
          return DevicesModel.fromMap(response.data);
        } else {
          throw Exception('Invalid data returned for devices');
        }
      } else {
        throw Exception('Failed to fetch devices: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching devices: $e");
      throw Exception('Failed to fetch devices: $e');
    }
  }

  Future<int> getTimestamp() async {
    try {
      final response = await api.get('$baseUrl/timestamp');

      if (response.statusCode == 200) {
        if (response.data is int) {
          return response.data as int;
        } else {
          throw Exception('Dados inválidos retornados pela API');
        }
      } else {
        throw Exception('Falha ao obter o timestamp: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao obter o timestamp: $e');
    }
  }

// POST /api/mqtt/publish
Future<void> publishMessage(String topic, String message) async {
  try {
    final response = await api.post(
      '$mqttUrl/publish',
      data: jsonEncode({
        'topic': topic,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      print('Mensagem publicada com sucesso.');
    } else {
      throw Exception('Falha ao publicar a mensagem: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Erro ao publicar a mensagem: $e');
  }
}

}
