import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/actuator_model.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/core/data/models/sensor_model.dart';
import 'package:smart_home_control/features/devices/presentation/pages/add_sensor_page.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart';

import 'add_actuator_page.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final FirebaseService _espService = FirebaseService();
  List<EspModel> _espList = [];
  bool _isLoading = false;
  Map<int, bool> _isExpanded = {};

  Future<void> _loadEspList() async {
    setState(() => _isLoading = true);
    try {
      final espList = await _espService.getEspList();
      setState(() {
        _espList = espList;
        _isExpanded = {for (var i = 0; i < espList.length; i++) i: false};
      });
    } catch (e) {
      UiToast.showToast('Failed to load ESPs: $e', ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addActuator(String espId) async {
    final newActuator = await Navigator.push<ActuatorModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddActuatorPage(espId: espId),
      ),
    );

    if (newActuator != null) {
      try {
        setState(() => _isLoading = true);
        await _espService.addActuator(newActuator);
        UiToast.showToast("Atuador ${newActuator.name} adicionado com sucesso",
            ToastType.success);

        // Atualiza a lista após a adição
        await _loadEspList();
      } catch (e) {
        UiToast.showToast('Failed to add Sensor: $e', ToastType.error);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addSensor(String espId) async {
    final newSensor = await Navigator.push<SensorModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddSensorPage(espId: espId),
      ),
    );

    if (newSensor != null) {
      try {
        setState(() => _isLoading = true);
        await _espService.addSensor(newSensor);
        UiToast.showToast("Sensor ${newSensor.name} adicionado com sucesso",
            ToastType.success);

        // Atualiza a lista após a adição
        await _loadEspList();
      } catch (e) {
        UiToast.showToast('Failed to add Sensor: $e', ToastType.error);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  // Método de confirmação genérico para exclusão de sensores/atuadores
  void _confirmDeletion(String espId, String deviceId, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('Tem certeza que deseja excluir esse $type?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeDevice(espId, deviceId, type);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  // Função para excluir dispositivo (sensor ou atuador)
  Future<void> _removeDevice(String espId, String deviceId, String type) async {
    try {
      setState(() => _isLoading = true);

      if (type == 'sensor') {
        await _espService.deleteSensor(espId, deviceId);
        UiToast.showToast('Sensor deleted successfully', ToastType.success);
      } else if (type == 'actuator') {
        await _espService.deleteActuator(espId, deviceId);
        UiToast.showToast('Actuator deleted successfully', ToastType.success);
      }

      // Atualiza a lista após a exclusão
      await _loadEspList();
    } catch (e) {
      UiToast.showToast('Failed to delete $type: $e', ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEspList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.devices, color: Colors.green),
        title: const Text('Dispositivos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _espList.isEmpty
              ? const Center(child: Text('No ESP devices found.'))
              : ListView.builder(
                  itemCount: _espList.length,
                  itemBuilder: (context, index) {
                    final esp = _espList[index];
                    final isExpanded = _isExpanded[index] ?? false;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.device_hub, color: Colors.green),
                              const SizedBox(width: 12.5),
                              Expanded(
                                child: Text(
                                  esp.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isExpanded[index] = !isExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (isExpanded) ...[
                            // Lista de Sensores
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sensores',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _addSensor(esp.id),
                                ),
                              ],
                            ),
                            if (esp.sensors != null && esp.sensors!.isNotEmpty)
                              ...esp.sensors!.map((sensor) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.thermostat,
                                    color: Colors.green,
                                  ),
                                  title: Text(sensor.name),
                                  subtitle: Text('Pin: ${sensor.pin1}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () {
                                      _confirmDeletion(
                                          esp.id, sensor.id, 'sensor');
                                    },
                                  ),
                                );
                              }).toList(),
                            // Lista de Atuadores
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Atuadores',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _addActuator(esp.id),
                                ),
                              ],
                            ),
                            if (esp.actuators != null &&
                                esp.actuators!.isNotEmpty)
                              ...esp.actuators!.map((actuator) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.toggle_on,
                                    color: Colors.green,
                                  ),
                                  title: Text(actuator.name),
                                  subtitle:
                                      Text('Output Pin: ${actuator.outputPin}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () {
                                      _confirmDeletion(
                                          esp.id, actuator.id!, 'actuator');
                                    },
                                  ),
                                );
                              }).toList(),
                          ],
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
