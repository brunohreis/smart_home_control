import 'package:flutter/material.dart';
import 'package:smart_home_control/core/data/firebase/firebase_service.dart';
import 'package:smart_home_control/core/data/models/device_model.dart';
import 'package:smart_home_control/core/data/models/esp_model.dart';
import 'package:smart_home_control/features/ui/toast/toast.dart';

import 'add_new_device_page.dart';

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
        title: const Text('Devices'),
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
                          // Nome do ESP com botão de expandir/retrair
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
                                  onPressed: () {
                                    // Lógica para adicionar sensor
                                  },
                                ),
                              ],
                            ),
                            if (esp.sensors != null && esp.sensors!.isNotEmpty)
                              ...esp.sensors!.map((sensor) {
                                return ListTile(
                                  leading: const Icon(Icons.sensor_door),
                                  title: Text(sensor.name),
                                  subtitle: Text('Pin: ${sensor.pin1}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // Lógica para excluir sensor
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
                                  onPressed: () {
                                    // Lógica para adicionar atuador
                                  },
                                ),
                              ],
                            ),
                            if (esp.actuators != null &&
                                esp.actuators!.isNotEmpty)
                              ...esp.actuators!.map((actuator) {
                                return ListTile(
                                  leading: const Icon(Icons.toggle_on),
                                  title: Text(actuator.name),
                                  subtitle:
                                      Text('Output Pin: ${actuator.outputPin}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      // Lógica para excluir atuador
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DeviceModel? newDevice = await Navigator.push<DeviceModel>(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewDevicePage(),
            ),
          );

          if (newDevice != null) {
            setState(() {
              // Adicionar novo dispositivo
            });
          }
        },
        tooltip: "Adicionar um novo dispositivo",
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
